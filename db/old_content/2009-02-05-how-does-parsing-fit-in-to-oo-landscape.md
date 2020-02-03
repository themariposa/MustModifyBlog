---
title: "How does Parsing fit in to the OO landscape?"
layout: 'post'
permalink: 2009/02/05/how-does-parsing-fit-in-to-oo-landscape
published: 2009-02-05 08:03:00 UTC
---
I've been working on a Ruby library for accessing the &quot;NefFlix API&quot;:http://developer.netflix.com/docs/REST_API_Reference . It's good fun, but it's brought me to some pain points that don't fit in to my &quot;OO is king&quot; worldview.

My current struggle revolves around parsing.

Should an object know how to parse its data from some external data source? This seems wrong. It's not part of the data model. Rails objects know how to populate themselves from a database, but those tables are internal to the system.

In lieu of going straight OO, I was thinking about an &quot;XSLT&quot;:http://en.wikipedia.org/wiki/Xslt transformation. Functional languages are great for stateless transformations. However, it seems like an unnecessarily high threshold to expect that others who use this code would have to be fluent in ruby and  xslt, neither of which is paticularly easy to pick up on the fly.

The problem is further complicated by the fact that different NetFlix resources provide different XML schemas for the same object. The NetFlix resource /catalog/titles/index returns (strangely enough) a _complete_ list of all NetFlix titles, while /catalog/titles is more of a search interface.

On the simple side, here is the XPath for finding the netflix webpage:

---
full list: //catalog_title_index/title_index_item/link[@title='  web page']/[@href]
search: //catalog_titles/catalog_title/link[@title='web page']/[@href]
---

On the complicated side, here's the code for finding out which formats ( ie DVD, Blue Ray or instant ) are available:
---
full list: 
//catalog_title_index/title_index_item/delivery_formats/availability[@available_from &gt; Time.to_i.to_s]/category[@label]

search: 
//catalog_titles/catalog_title/link[@title='formats']/[@href]
---

Unfortunately, the search interface doesn't actually provide the list of formats. It just gives you a link to a resource that will provide that information (ie http://api.netflix.com/catalog/titles/series/70023522/seasons/70023522/format_availability). This is also true for the title of the Title (ouch, awkward... ) [C'mon, NetFlix, you couldn't have called it something less awkward, like, uh, name?]

My initial direction was to create a Parser object. After five methods, with not nearly enough in the way of functionality, I started to see that this single object would be too overworked. I looked at GOF patterns. The Builder Pattern seems to be the right choice here. I'm going to start by trying to create a builder object for every object model. I only have one model so far, but I know the API includes many resources.

A side benefit to using this pattern is that it allows me to use seperation of concerns to simplify my Display Format issue. I can create a DisplayFormat model that has the availability and format information. the DisplayFormatBuilder can accept the title's xml and handle those two cases above. In the case where a seperate call is needed, I can even use Lazy Initialization.

I was beginning to worry that OO didn't have a good solution to my parsing problem, but the GoF has saved the day again!
