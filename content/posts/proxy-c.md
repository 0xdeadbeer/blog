---
title: "proxy.c"
date: 2024-08-07T00:20:45+02:00
---

I am writing a HTTP/s proxy server from scratch in C. So far
I have successfully implemented basic HTTP proxying. Much work 
still has to be done though. I am looking for interested folks who would 
be interested in helping me and build a bond to advance this project further, 
if their interest or passion is genuine and strong. 

The reason for such an absurd goal is to write a new terminal
foss wanna-be BurpSuite hacking utility. One that does not impose 
hard delay limits on the user's requests nor hides any functionality
behind an expensive license - like BurpSuite. I want this to be a swiss army knife
of my hacking days. Potentially helping my-future-self and, if this really succeeds,
other web security engineers as well - a dream. Thus I am looking forward to 
any contacts at [jerebica dot kevin at gmail](mailto:jerebicakevin@gmail.com) from 
interested candidates. 

In the meantime, you can take a look at the progress or source-code 
of the proxy.c at [tesseract:81/0xdeadbeer/proxy](http://104.248.140.85:81/0xdeadbeer/proxy) - my self-hosted Gitea instance

Current TODO list: 

  * Parse port out of Host header (default_value:80)
  * Implement server message parsing
  * Verify and search for memory leaks
  * More testing, debugging, fixing
  * Implement HTTPS with OpenSSL

