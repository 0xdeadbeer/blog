---
title: "TLPI: Linux Signals"
date: 2023-04-29T16:21:24+02:00
tags: ["linux"]
---

## 0 Introduction

I have started reading The Linux Programming Interface! And throughout the book
I will be writing some cool articles regarding new things I learned. The book
is being read in no particular order, so expect the articles to follow that
non-orderness (if that is even a word). In this article specifically, however,
I will be writing about signals. What are signals? How do they work? How to
implement them inside my own program? and much more. 

> Note: If you want to follow along, this article is based on the 20th chapter
> of the book (Signals: Fundamental Concepts). I may add my own tips and
> lessons from time to time though. 

## 1 Signals 

In short, signals are software interrupts. During the program's execution, if
the program receives a signal, it will stop the program's execution and finish
some new and more important job. That job can depend on which signal was fired
and what the program is set to do after receiving that specific signal.

"Ok, in what context is that useful?" you might ask. Well, a simple example
might be killing a program through the shell. If you have worked with Linux for
long enough, you might know that pressing CTRL+C kills any currently pending
program that was executed from the shell. All the shell is really doing is
waiting for keyboard input, and sending a specific kill signal to the program.

There is more signals than just the kill signal though (i.e. SIGINT or SIGKILL
in many cases)

Usually, every signal has it is own default action that should be taken after
the program receives it. But guess what, we can change it! That is called
Signal Disposition. And we can change it to: ```func(int)``` ```SIG_IGN``` or
```SIG_DFL```

 - ```func(int)```: could be a custom function that we want to execute when the
   signal is received.
 - ```SIG_IGN```: just ignore the signal (i.e. no action for a specific signal)
 - ```SIG_DFL```: execute default action of the signal (whatever it may be)

And we can do so, using either:

    void (signal(int sig, void (func)(int)))(int);

or a more flexible/complex alternative:

    int sigaction(int sig, const struct sigaction act, struct sigaction
    oldact);

both of which are defined in ```<signal.h>```

# 2 Sending signals

Signals can be sent using the following function.

    int kill(pid_t pid, int sig);  // send signal to a process int killpg(int
    pgrp, int sig); // send signal to a process group

Or an alternative (in case you want to send the signal to the same program)
    
    int raise(int sig); // literally the same as the line below kill(getpid(),
    sig);

You might be already familiar with the program ```kill``` from the command
line. And in case you are wondering.. well, yeah, they serve practically the
same purpose.

> Note: Just because they are named kill, it does not mean that they
> specifically have to kill a process. It is just called that way because
> originally you could in fact, only kill processes. But now you can send
> various signals with it (and also check if a PID is in use - more on that
> later).

## 3 Signal mask

What if we want to block a signal? Or just temporarily let the program know
that we do not want to accept certain types of signals? In that case we use
something called a Signal Mask.

You can use the following function to change/edit the process signal mask. 

    int sigprocmask(int how, const sigset_t set, sigset_t oldset);

> Note: ```sigset_t``` is a type of data structure that can contain all types
> of signals. Imagine it more like a dictionary than a Queue or array where you
> can find multiple elements of the same signal type. 

> Hint: More information can be found
> [here](https://www.gnu.org/software/libc/manual/html_node/Process-Signal-Mask.html)

If a signal of a specific type is being sent to a process which blocked that
type, it will be marked as pending and will be delivered once the signal mask
unblocks it (if ever).

If you want to view all the currently pending signals you can do so, using the
following function. 

    int sigpending (sigset_t set);

> Note: Yes, it does return a signal set, and so no matter how many pending
> signals of a blocked type you will send, they will still be counted as one
> and sent only once after they are unblocked. As I have said, this is not a
> queue, but more like a dictionary.. or.. queue where duplicates do not exist.

## 4 Pause 

If you want to suspend the execution of the program and wait for signals, you
can do so using the following function

    int pause(void);

> Note: from what the book said, yes, it is more optimal to use pause than to
> use a loop. Although I did not verify this in practice, I am giving it the
> benefit of the doubt. You can verify it yourself if you care that much about
> program timings.

