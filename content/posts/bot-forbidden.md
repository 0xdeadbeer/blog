---
title: "Getting Rid of Bots"
date: 2025-04-25T19:18:53+02:00
---

In my [previous post](/posts/dead-internet-theory) I released the statistics of human vs. bot traffic for my whole website. Human traffic 
makes up 3% of the total requests I logged since the 9th of April - 50 thousand requests. 

With this, it is clear that bots have to go. I do not want my server to waste needless bandwidth on crawlers, 
A.I. bots, directory enumerators, sshd enumerators, etc. 

This allowed me to finally get comfortable with fail2ban. A daemon which polls your logs in search of specific 
regex patterns which you configure. If it detects N matches from a specific IP inside a certain time period M,
it throws the IP in a jail for W amount of time. Needless to say, those parameters are all configurable.
