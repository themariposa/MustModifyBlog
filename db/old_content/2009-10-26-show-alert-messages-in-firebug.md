---
title: "Show alert messages in firebug"
layout: 'post'
permalink: 2009/10/26/show-alert-messages-in-firebug
published: 2009-10-26 15:50:00 UTC
---
A cool javascript trick:

---
alert = console.log
---

then

---
alert('hello')
---

will show up in Firebug instead of an alert screen:

---
&quot;hello&quot;
---
