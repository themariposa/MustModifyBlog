---
title: "tail - follow two to n files at once"
layout: 'post'
permalink: 2010/01/27/tail-follow-two-to-n-files-at-once
published: 2010-01-27 06:59:00 UTC
---
I often use tail -f filename.txt ... then recently I realized I was switching back and forth between test.log and development.log, and that only one was being used at a time -- could I follow both at the same time?

Turns out you can, and really easily.
---
tail -f file1.txt file2.txt
---
or even
---
tail -f log/*.log
---

useful and easy. eureka!
