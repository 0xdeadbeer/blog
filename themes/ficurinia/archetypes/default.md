---
title: "{{ replace (replace .Name "-" " ") "_" " " | title }}"
date: {{ .Date }}
tags:
  - tag1
  - tag2
  - tag3
image:
comments: true
---

