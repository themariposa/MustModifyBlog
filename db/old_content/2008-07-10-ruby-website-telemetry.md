---
title: "Ruby Website Telemetry"
layout: 'post'
permalink: 2008/07/10/ruby-website-telemetry
published: 2008-07-10 10:18:00 UTC
---
from Telemetry on Wikipedia:

*Telemetry* is a &quot;technology&quot;:http://en.wikipedia.org/wiki/Technology that allows the remote measurement and reporting of &quot;information&quot;:http://en.wikipedia.org/wiki/Information of interest to the system designer or operator. The word is derived from &quot;Greek&quot;:http://en.wikipedia.org/wiki/Greek_language roots _tele_ = remote, and _metron_ = measure.

Triage on production Ruby on Rails sites can be troublesome. There are a few tools that provide narrow visibility into the state of things, my MyTop.rb. However, this is the kind of radiator that you view only when you know you have a problem. This becomes somewhat dissatisfying when you are in charge of keeping things afloat. One starts to thing that a professional developer should be able to know when the website is broke before hearing about it from Level 2 Tech Support.

I've been craving something that would be more versatile in scope, more proactive and extensible.

In a seperate blog post, I'll be maintaining a list of vital signs that need implementing:


Roadmap:
- First Test
- Controller
- Command Line UI
- Web UI
- History
- Events
- Notifications - email, web, sms?, jabber, growl?, beta_brite
- Graphing
- Notification Escalation
- Nuisance Alarm Silencing
- Recommendations / Fixes
- AutoCorrection
- Trending
- RSS

Reference Sites:
- http://bb4.com/product_features.asp
- &quot;Monitoring MySQL Performance&quot;:http://www.mysql.com/news-and-events/newsletter/2004-01/a0000000301.html 
