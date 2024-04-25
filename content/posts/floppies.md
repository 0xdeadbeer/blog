---
title: "Floppies"
date: 2024-04-25T21:21:30+02:00
---

![Floppy Reader](/images/floppies/pic1.jpg) Floppy reader positioned on my 2
year old custom-built PC. What an occurrence! The old meets the new hahah

A youngster like me could hardly appreciate the simplicity behind these things,
let alone the struggle elders had to go through to work with such technology. I
was searching for a male aux to male aux connector the other day and stumbled
on this reader with a stack of floppies nearby. The mounting process was
unsurprisingly easy since I am running Linux. I have no idea what is the case
with Windows, and franky, I do not care at this point in time. I rush to my
computer in all awe, excited to see what obscure and ancient data these might
have in them or how they even work. Most had MS DOS executables and Batch
installation scripts for some kind of software as well as some XLS tables and
other uninteresting data. 

The mounting process had a peculiarity though.. I had to mount the whole disk
and not just a partition whose file-system has been recognized by the kernel
(`mount /dev/sda /mnt` instead of `mount /dev/sda1 /mnt`). Is that weird? I do
not know..

After minutes of staring at these boring files and finding nothing that would
suffice my interest.. I have decided to format one of the floppies with an ext4
file-system and make it my personal mini space. It is not like I can fit 4K
images in here, but a couple of text files will suffice. 

![Interesting Floppies](/images/floppies/pic2.jpg) Here I collected all
diskettes with English shortnotes

An interesting feature of floppies is that you can forcibly restrict the
reader's head from writing to the disc by flicking a tiny switch on the bottom
right side of the plastic cover. Not all floppies have that switch though.

One thing I learned from researching floppies is their design mechanism. From
what I read, they work magnetically just like modern hard disks and beneath the
plastic is located the actual disc where the data is stored. When you insert
the floppy into the reader, it flicks the metal shield, exposing the internal
disc (black rectangle), attaches to it a read/write head and there it operates
according to the system's commands (reading/writing the data while the disc
spins around).
