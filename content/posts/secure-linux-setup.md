---
title: "Secure Linux Setup"
date: 2023-04-12T11:53:13+02:00
tags: ["linux", "internet security", "privacy"]
image: /images/memes/oh_no.jpg
---

This post is dedicated to the ones that have been in the Linux game for years now or have just started experimenting, but don't have a very secure system. 
But wait, what do I mean by *secure*? Well, a lot of factors come down to how secure your system is. **And by no means I'm claiming that this will 
be a guide to *perfect security*. Let alone *perfect anonymity*.** That's simply because you cannot be 100% secure and anonymous online. It's a fact. 
What I want to teach you with this post, is how to increase your anonymity. How to increase your security. How to make your life easier in case something 
bad happens to your data. 

Throughout the post you may notice how nicely all the security practices connect. One being dependent of the other. Creating a nice security framework for your computer.

--- 

First off, you have to understand how important data is. You need to have a reason to hide or protect it. The reason usually comes after some time when you realize
how much surveillance is happening on a tick-per-tick basis. The possibility of you giving a shit about your data can go even lower if you're still a teenager. 
After you get a job, mature, realize how cruel the world is, you'll start caring much more about freedom in general. And so should you about Internet freedom, privacy, security, etc.

## 1 Passwords

Let's talk ~~basics~~ passwords. They're not that simple to deal with. I know that. We all do. And so, let's facilitate it to a concept that you're already familiar with - Password Managers. 
No, I'm not going to be selling you a Password Manager, or telling you about this awesome service that helped me stay secure for the past X years. Keeping your credentials on a third-party service is not even a good option - as you can see [here](https://www.youtube.com/watch?v=cRsn0PlnuvM). 
I'm going to give you an open-source tool that has made my life eaiser when dealing with passwords. You're free to find alternatives, but for me, this was the best I was able to find. 

It's called [KeePassXC](https://keepassxc.org/). It's cross-platform and you can run it on Linux - which is exactly what we needed. Passwords are stored in a file called a *Database* which contains groups. 
A group can either contain more groups, or simply passwords. The whole database is by default encrypted with the industry-standard AES256 and a key provided by the user (make sure it's a long one that you can remember).

For more security, the user is advised to distribute passwords across multiple databases. For example: 
 - **VMs database:** passwords regarding all VMs on the user's computer (VM's encrypted disk, users, etc.) 
 - **Hardware database:** passwords regarding user's hardware (encrypted USB keys, hard drives, etc.)  
 - **Social database:** passwords regarding social media 
 - **Finance database:** passwords regarding finance (bank accounts, crypto accounts, etc.) 
 - **Work database:** passwords regarding your work

## 2 VMs (Virtual Machines)

Virtual machines are so underrated for desktop usage. And that's sad because they're so flexible and useful when it comes to security!
Example of a VM security framework: 
 - **Gaming VM**: strictly use for gaming ([#moreinfo](https://www.youtube.com/watch?v=BNLnTCqUMyY))
 - **Work VM:** strictly use for work stuff
 - **Social VM:** strictly use for social media
 - ...

> **💡 Hint:** notice how password databases can now be isolated across your VMs. So each VM has only the passwords **it** needs.

## 3 Backups

Backing up important information is very important. Especially if your income depends on it. This might include the password databases I've mentioned earlier, high importance VMs,  
pictures, projects, work, presentations, plans, goals, etc. First, if you've got some money to spare, invest 100-200 dollars into backup disks because you're gonna need them. 
Else you can simply try to get them over a longer period of time, or backup your things to USB sticks. After that, you have two options: 
 - Find some backup tool that does all the hard work
 - Script your own tool - giving you more freedom to customize the backup system 

In my case specifically, I like designing the structure of my computer. And so, I created [my own script](https://gist.github.com/0xdeadbeer/1393329c9d08b858befe384cbf1e2142). You can use it if you want.
With that step done, you have to automate the process of calling this tool X times per day. X may depend on how you design your backup system, but for me 3 to 2 times each day is more than enough.

> **💡 Hint:** such automation is usually achieved with [cronjobs](https://victoria.dev/blog/a-cron-job-that-could-save-you-from-a-ransomware-attack/).

Another cool thing you can do is self-host a server and send backups over there. Or even better, agree with more people to host a server somewhere and each have your own copies over there. Of course, don't forget about encryption and access permissions ;)

> **💡 Hint:** backups over network can be achieved with [rsync](https://linux.die.net/man/1/rsync) or [rclone](https://rclone.org/) as far as I know. 


## 4 File Recovery

Be careful how you delete files. Especially if you're going to be selling your disk or something. Data may not be 100% deleted like you think it might be. That's why I never buy/sell used disks. Because it's just not worth it. 
For the sake of security, whenever you delete a file, it usually just gets flagged as "NEW DATA, OVERWRITE ME PLEASE". And so you haven't actually *deleted* the contents, you've just removed it from the filesystem's structure and told it that what was once a file is now *usable space waiting to be overwritten*.

And guess what, that data which hasn't been yet overwritten can be read. And pretty easily I might add. [#moreinfo1](https://www.youtube.com/watch?v=0WcrgvhO_mw) [#moreinfo2](https://wiki.archlinux.org/title/file_recovery)

But how do you make sure it is actually deleted? Well, a good tool to look into is [shred](https://wiki.archlinux.org/title/Securely_wipe_disk) (Securely Wipe Disk)

> **💡 Hint:** a cool one-liner I've learned recently from [Luke Smith](https://www.youtube.com/channel/UC2eYFnH61tmytImy1mTYvhA) is ```dd if=/dev/random of=/tmp/erase_secrets; rm -rf /tmp/erase_secrets```. The command fills the disk with random data (overwriting all the not-fully-deleted-data and then deallocates the file from the file-system). 

--- 


> **✨ Something new:** recently I was introduced to the concept of SELinux. And although it might fit this post perfectly, I'm failrly new to that concept so it's excluded for now. I might edit it in the future or make a new post altogether. Of course, if you're interested, here's a [link](https://selinuxproject.org/page/Main_Page)
