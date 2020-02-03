---
title: "Session Data / Cookies don't persist in IE"
layout: 'post'
permalink: 2010/05/21/session-data-cookies-lost-in-ie-explorer
published: 2010-05-21 06:42:40 UTC
---
Rails fails with 500

I spent at least six hours isolating this issue so I thought I'd save someone else some trouble.

Say you have a site fu.com ... if you're doing any SEO work (or if you just want things to be clean) you'll 301 redirect all traffic from fu.com to www.fu.com. You can do this with Rails with a before_filter in your Rails ApplicationController. 

When the user hits http://fu.com, Rails may send back a session-expiring cookie with your session id. It then redirects the user to http://www.fu.com. Rails may send back a session-expiring cookie from that domain. This confuses IE and causes it to ignore changes to the session cookie.

The trivial fix is to move the redirect upstream, in my case to Apache.

It's odd that this didn't happen in firefox or chrome, so I assume there's more to the story, but it's working now so I'm leaving it alone. :)
