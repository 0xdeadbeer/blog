---
title: "Bad Bot Statistics For My Website"
date: 2025-04-24T00:54:16+02:00
---

Context: ["Dead Internet Theroy Confirmed: 51% of Traffic now Non-Human"](https://www.youtube.com/watch?v=ofWmufzwUNo)

My droplet runs on Apache2. A bit of text manipulation tells me that since the 9th of April:
 - it served about 50k client requests - in total.
   - `cat access.log* | wc -l` outputs `52818`
 - 48k of which contained the word "bot" in their apache access log line.
   - `cat access.log* | grep -i "bot" | wc -l` outputs `48396`
 - 2k of which did not. 
   - `cat access.log* | grep -v -i "bot" | wc -l` outputs `2018`

With this I can confidently say that barely 3% of my total traffic is not an A.I. bot. 
I certainly cannot classify private, custom, hacking bots. Which is why I round the number and 
say ~3% while the math shows 3.82%. A bit of searching through the access.log files shows numerous 
requests of dictionary attacks and the like. Which is why I am rounding the percentage down in the 
first place and call THAT my end estimate of normal, healthy traffic.  

Let me say it again. In a span of 15 days, my server received 50k client requests and a good 3% of which 
was normal, healthy traffic.

Ah, long time no see! Mobsecurity!
