---
title: "it's Valuable -- like attr_accessor on steriods"
layout: 'post'
permalink: 2009/01/30/its-valuable-like-attraccessor-on
published: 2009-01-30 13:37:00 UTC
---
Take a look at the &quot;ruby gem named valuable&quot;:http://valuable.mustmodify.com

I recently worked on a Rails project where most of the domain-related data came from a HyperCube database, rather than a relational one. I have to admint, albeit begrudgingly, that it provided a lot of value. Conversely, the interface was crazily complicated, and incorporating non-relational data with Rails was at best incrediby painful.

One &quot;feature&quot; of the hypercube was that we didn't ever get a complete schema. Data was provided when it was available, and when it wasn't available, it just didn't exist. For instance, a category might have a collection of items. If there were no items, there was no empty collection. 

We needed a dry way to model the parts of the data we were using. We also wanted to be able to transparently ignore any other data that might unexpectedly appear. Finally, for my own sanity, I wanted it to feel as much like a rails model as possible.

Goals:
  * dry class decorators
  * generate getters and setters for each attribute
  * generate a class-level list of the attributes we handled
  * provide an instance-level attribute hash like Rails 
  * optionally provide light-weight type casting ( '3' + '3' is not the same as 3+3)
  * allow default values

From the Readme, Here's an example of its usage.

---ruby
class BaseballPlayer &lt; Valuable::Base
   has_value :at_bats, :klass =&gt; Integer
   has_value :hits, :klass =&gt; Integer  
   has_value :jersey, :klass =&gt; Jersey, :default =&gt; 'unknown'  
   has_value :league, :default =&gt; 'unknown'  
   has_value :name
   has_collection :teammates

   def roi
      hits/at_bats.to_f if hits&amp;&amp;at_bats
   end
end

class Jersey &lt; String
   def initialize(object)
      super &quot;Jersey Number #{object}&quot;
  end
end

&gt;&gt; joe = BaseballPlayer.new(:name =&gt; 'Joe', :hits =&gt; 5, :at_bats =&gt; 20)
&gt;&gt; joe.at_bats 
=&gt; 20
&gt;&gt; joe.league
=&gt; 'unknown'
&gt;&gt; joe.roi=&gt; 0.25
&gt;&gt; joe.at_bats = nil
&gt;&gt; joe.roi=&gt; nil
&gt;&gt; joe.teammates=&gt; []
&gt;&gt; joe.jersey
=&gt; 'unknown'
&gt;&gt; joe.jersey = 20
&gt;&gt; 'Jersey Number 20'
---

This has also come in handy with the Flix4r code I've been writing... more about that soon.
