---
title: "Debugging multiprocessing software with GDB"
date: 2024-09-28T14:33:17+02:00
---

## <i>Backstory</i>

Since ever I started the development of my high school finals project - [a proxy library](http://git.0xdeadbeer.xyz/0xdeadbeer/proxlib) - 
I have had the desire to master the art of debugging multiprocessing software.
Up until now I had no idea it was even possible due to the scarse general
information available about it. 

`set follow-fork-mode [mode]` seemed promising and quite honestly, worked as expected.
Except, I realized that to debug my proxy, I was in need of a more dynamic approach such as:
 - being asked whether to follow the child/parent as I catch multiple forks
 - switching between the parent or multiple children instantly 
 - releasing the parent while I only debug the child or vice versa

I read more about it online and it seemed as if the first of my requirements was an already supported feature 
of GDB - (`set follow-fork-mode ask`) - which would ask the user at runtime whether they want to follow 
the child or the parent the second they hit a fork/vfork syscall. Sadly, newer versions of GDB have had it cut off 
and deprecated for whatever reason. 

The frustration got me really close to taking initiative and writing myself a little patch for the modern versions of GDB
so they would also have this useful feature. But something told me there had to be a better way. And oh boy, better way there was.

## <i>Start</i>

{{< highlight go-template "linenos=inline" >}}
/* main.c */

#include <stdio.h>
#include <unistd.h>

int main(void) {
    fprintf(stdout, "--multiprocessing example--\n");
    for (int i = 0; i < 5; i++) {
        pid_t pid = fork();
        if (pid == 0) {
            fprintf(stdout, ">>hello from child: %d\n", i);
            return 0;
        }
        if (pid < 0) {
            fprintf(stderr, ">>failed forking\n");
            return -1;
        }
    }

    fprintf(stdout, ">>hello from parent\n");

    return 0;
}
{{< / highlight >}}

We are going to step through this program - getting into the nitty griddy of debugging and seeing 
what options we have depending on our demands. First of all, use your compiler of choice. I am going to use 
GCC and turn on debugging info.

    gcc -g3 main.c -o main

Before we continue, make sure you at least have the following setting enabled in .gdbinit:
    
    set detach-on-fork off

A very convenient option that will block execution of both the parent and the new child - not 
letting one of them run unless you manually call continue.

## <i>Following the parent</i>

This scenario is unsurprisingly simple. GDB does this automatically, therefore, I will not cover it.

{{<highlight go-template "linenos=inline" >}}
[hemisquare@detached-hemi tmp]$ gdb main
(gdb) break main 
Breakpoint 1 at 0x1161: file main.c, line 7.
(gdb) run
Starting program: /home/hemisquare/tmp/main 
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".

Breakpoint 1, main () at main.c:7
7	    fprintf(stdout, "--multiprocessing example--\n");
(gdb) s
--multiprocessing example--
8	    for (int i = 0; i < 5; i++) {
(gdb) 
9	        pid_t pid = fork();
(gdb) 
[New inferior 2 (process 51915)]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".
10	        if (pid == 0) {
(gdb) p pid
$1 = 51915
(gdb) # we are the parent
{{</highlight>}}

## <i>Following the child</i>

Similar to the parent example, I will step until we hit the first fork syscall.

{{<highlight go-template "linenos=inline" >}}
[hemisquare@detached-hemi tmp]$ gdb main 
(gdb) break main
Breakpoint 1 at 0x1161: file main.c, line 7.
(gdb) run
Starting program: /home/hemisquare/tmp/main 
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".

Breakpoint 1, main () at main.c:7
7	    fprintf(stdout, "--multiprocessing example--\n");
(gdb) s
--multiprocessing example--
8	    for (int i = 0; i < 5; i++) {
(gdb) 
9	        pid_t pid = fork();
(gdb) 
[New inferior 2 (process 52175)]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".
10	        if (pid == 0) {
(gdb)
{{</highlight>}}

So, currently we are inside the parent "inferior". And inferior is just a GDB term for processes, threads, or whatever it is that you are debugging.
Through forks, we create another inferior which we can switch to. As you can see, we now have two inferiors:

{{<highlight go-template "linenos=inline">}}
(gdb) info inferiors
  Num  Description       Connection           Executable        
* 1    process 52172     1 (native)           /home/hemisquare/tmp/main 
  2    process 52175     1 (native)           /home/hemisquare/tmp/main 
(gdb)
{{</highlight>}}

The '*' indicates the inferior we are currently residing in. Inferior 2 is the newborn child we just forked.
Let's switch into the child!

{{<highlight go-template "linenos=inline" >}}
(gdb) inferior 2 
[Switching to inferior 2 [process 52175] (/home/hemisquare/tmp/main)]
[Switching to thread 2.1 (Thread 0x7ffff7dab740 (LWP 52175))]
#0  0x00007ffff7e90b57 in _Fork () from /usr/lib/libc.so.6
(gdb) finish
Run till exit from #0  0x00007ffff7e90b57 in _Fork () from /usr/lib/libc.so.6
0x00007ffff7e966e2 in fork () from /usr/lib/libc.so.6
(gdb) finish
Run till exit from #0  0x00007ffff7e966e2 in fork () from /usr/lib/libc.so.6
0x0000555555555192 in main () at main.c:9
9	        pid_t pid = fork();
(gdb) nexti
10	        if (pid == 0) {
(gdb) p pid 
$1 = 0
(gdb) s
11	            fprintf(stdout, ">>hello from child: %d\n", i);
(gdb) 
>>hello from child: 0
12	            return 0;
(gdb) 
{{</highlight>}}

As you can see, here, we were able to step through the code of the child. Notice that the parent is still handing where we 
left it at. It is totally okay to now switch back into the parent inferior and continue the execution from there.

## <i>Conclusion</i>

Knowing this is essential for debugging my proxy library. I am thankful I now know GDB just a little better and was 
hopefully able to provide you with a useful learning resource. I might extend this article in case I master more 
interesting multiprocessing or multithreading techniques.
