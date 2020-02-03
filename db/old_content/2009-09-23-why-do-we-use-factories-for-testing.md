---
title: "Why do we use factories for testing?"
layout: 'post'
permalink: 2009/09/23/why-do-we-use-factories-for-testing
published: 2009-09-23 07:42:00 UTC
---
A client recently asked me why we used factories in our tests. Here's my answer:

Originally, people would create a new instance of every model in every test. So, if you were testing that we properly parse dates and know which ones are valid and which aren't, and you know that Person requires a name, you might write:
---
Person.new(:name =&gt; 'fiona', :dob =&gt; '3/5/12').should be_valid
---
and that was cool
then eventually:
---
validates_presence_of :emailvalidates_presence_of :favorite_color
---
then
---
Person.new(:name =&gt; 'fiona', :email =&gt; 'fiona@gmail.com', :dob =&gt; '3/5/12', :favorite_color =&gt; 'red').should be_valid
---
and
---
Person.new(:name =&gt; 'fiona', :email =&gt; 'fiona@gmail.com', :dob =&gt; '3/12', :favorite_color =&gt; 'red').should_not be_valid
---
just to make sure we were properly parsing dates and ensuring we got a complete one.

and so that was moderately painful, but then...

we split name into first_name and last_name

and then we have to change 75 tests

so then someone said, &quot;This is really painful.&quot;

&quot;Let's create a default Person, and just modify it when we want to test things.&quot;

and the solution followed the &quot;GoF pattern called Factory&quot;:http://en.wikipedia.org/wiki/Abstract_factory_pattern so that's what they called it.
