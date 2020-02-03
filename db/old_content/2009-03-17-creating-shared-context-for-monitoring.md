---
title: "Creating a Shared Context for Monitoring the Health of an Application"
layout: 'post'
permalink: 2009/03/17/creating-shared-context-for-monitoring
published: 2009-03-17 02:52:00 UTC
---
As part of my vital signs project, I'm building a framework for monitoring the health of an application based on various ways of 'taking its temperature'. Each vital sign will measure something specific (drive space left on the server,  database requests per second, etc.).  

The point of this project is to quickly give  _any_  viewer an idea of the health of the system. I mean  _any_  viewer. If the Grand Poobah in charge of Water Buffalo stops by, I want the new intern to be able to bring the VIP up to speed on the results immediately. 

Unfortunately, raw data requires too much context. Hard drive space is bad below 50,000 and db requests per second are bad above 150, and there are 10, 100 or 1000 metrics with different thresholds. While we do need to collect all this very disparate raw data, we  _must_  display results in that are simple and uniform.  

By convention, we'll report all results on a scale from 0 to 100:
100 =&gt; Optimal
75 .. 99 =&gt; Acceptable 
50 .. 74 =&gt; Check Engine 
25 .. 49 =&gt; Warning Will Robinson! 
01 .. 24 =&gt; Critical 
00 =&gt; Down

If a VP passes looks up at the 42-inch monitor in his office (which flashes charts and ... whatever ... ) and notices that db requests per second is at 30, I want that person to pick up the phone, call me, and say, &quot;Hey, something's wrong.&quot; This is way better than hearing, &quot;How could you let this happen? And why is 30,000 requests per second a problem, anyway?&quot;

Hopefully the end result will look something like this:
* Overall Health is Prominent (and uses Shared Context) 
* Nested Data uses Shared Context for Results 
* Color Coded for Additional Context
* I would also like to see &quot;Spark Lines&quot;:http://www.edwardtufte.com/bboard/q-and-a-fetch-msg?msg_id=0001OR for historical context.

APPLICATION HEALTH:
70/100 
84  Drive Space 
92  DB Requests per Second 
52  HTTP Request Time 
64 Longest Running DB Request

