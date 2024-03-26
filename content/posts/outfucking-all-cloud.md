---
title: "Outfucking All Cloud"
date: 2023-04-17T18:29:38+02:00
tags: ["internet", "internet security", "privacy"]
---

## Introduction

Lately, I have been facing a serious issue with my backup system. The problem
was the following. I usually keep backups scattered across all of my disks in
order to fulfill some basic availability rule. However, the problem arises when
you notice that all of those disks are always connected to my computer, which
does not have any lightning protection. And since I have been getting quite
cautious about my spendings, I would rather avoid buying a surge protector of some
sort. And so, in case of a lightning strike, all of those backups will be gone.
Parts of the computer included. Therefore, the most elegant solution to this
problem? Rclone!

## Outcome

Let me explain my solution. If you read my [Secure Linux
Setup](/posts/secure-linux-setup/) article, you may have noticed I have a
strong will to protect my data. And so, you might expect me to be all against
cloud. And to be fair, I surely am. That is, when I serve them raw data heheee

Problem is, I cannot afford a server at the moment. And cloud really seems like
the only option to choose for high availability. Therefore, I did exactly what
you would expect from a Linux security-conscious person o.o 

Take my files, zip them, encrypt those fellas like no tomorrow, and finally
send them over to the big tech. 

That is right, I am encrypting all my data before sending it online. Crazy right?
Who would have thought? No but for real, I do not know why I did not start doing it
before. For the ones that want even more security over their data, you may as
well just encrypt it multiple times with different keys before sending it
online. 

## /bin/bash

A couple of months ago I saw somebody mention it inside one of the Linux
servers that I am in. I did not give it too much thought at that time, I thought
that local backups were all I needed to stay safe. But after realizing the
problem (two weeks ago), I started digging into the tool and realized how cool
it actually is. All I had to do was create a project inside the Google API
console, create a basic consent screen, generate a client ID & secret, and
BOOM! The dopamine hit I was looking for!

I was able to mount my Google Drive as a "disk" onto my Linux filesystem. That
inspired me to create another backup script, which would serve the cloud with
my encrypted data multiple times a day.  

I am not joking when I say that this tool is fucking awesome! Just look at what
it takes to mount my Google Drive to /mnt: ```rclone mount main_gdrive: /mnt```

For the curious individuals, [this](https://rclone.org/drive/) is the guide I
followed, and this is my new [backup
script](https://gist.github.com/0xdeadbeer/be247747968840f3748ffa7a60d0f0be)

> Hint: It is recommended to encrypt your Rclone config
> (```~/.config/rclone/rclone.conf```) also. Fortunately, that functionality is
> already provided by Rclone whenever you use it so you do not have to
> encrypt/decrypt it on your own. On the other hand, you may choose to do so to
> have more control over what algorithm to use when encrypting the config. But
> for more security, please encrypt your configs, since they usually hold all
> sorts of sensitive information (especially in Rclone's case)...

> Note: It is likely that I will be forced to change my backup scripts
> because of obvious privacy reasons. But I hope you get the idea.


