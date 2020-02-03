---
title: "Get a List of Bad Links from Rails Log"
layout: 'post'
permalink: 2009/10/22/get-list-of-bad-links-from-rails-log
published: 2009-10-22 10:23:00 UTC
---
If you have a Ruby on Rails app and you want to generate a list of the URLs that have generated 404s from your logs, here's one way:

---
perl -n -e '/No route matches &quot;(.*)&quot; with .*/&amp;&amp;print &quot;$1\n&quot;' log/production.log | sort | uniq&gt;public/bad_paths.txt
---

then view:
http://production_site/bad_paths.txt

We're using Passenger, and I'm not sure to what extent passenger is involved in the format of the Rails logs -- I would assume it's not, that wouldn't be very Railsy, but if it doesn't work, that might have something to do with it.

Anyway, unix is cool.
