---
title: "Ruby Hash constructor -- useful, unintuitive"
layout: 'post'
permalink: 2009/03/12/ruby-hash-constructor-useful
published: 2009-03-12 12:54:00 UTC
---
I've been confused in the past about the behavior of &quot;Ruby's Hash constructor&quot;:http://ruby-doc.org/core/classes/Hash.html#M002868 . Now that I've looked at the documentation, I have to say I think it violates the principle of least surprise.

A default hash returns nil any time you access a key with no set value. The default value can be changed through the constructor. This can be useful when you want to do something like this...
---ruby
&gt;&gt; brownie_points = {}
=&gt; {}

&gt;&gt; brownie_points[:zack] += 2
NoMethodError: undefined method `+' for nil:NilClass

&gt;&gt; brownie_points.default
=&gt; nil

&gt;&gt; brownie_points = Hash.new(0)=&gt; {}

&gt;&gt; brownie_points.default
=&gt; 0

&gt;&gt; brownie_points[:zack] += 3
=&gt; 5

&gt;&gt; brownie_points[:sam]
=&gt; 0
---

We can all agree that this is useful. Moreover, developers will rarely use the constructor, because the ruby language construct {} is so much more elegant. I just don't see myself doing a lot of this...

---ruby
attributes = {:key_one =&gt; :value_one}
Hash.new(attributes)
---

That being said, the prime directive isn't we aren't using that method let's do something with it . It's the principle of least suprise . Not only that, but it violates a pretty universal convention in all of OO that objects' constructors will accept values that make up their initial state. Instead, it accepts the value to return when you ask for something outside it's current state.

To work around this problem, ruby includes a class-level method [].

---ruby
&gt;&gt; Hash[:frank =&gt; 'friendly', :zack =&gt; 'here let me thread that for you', :panda =&gt; :zen]
=&gt; {:zack=&gt;&quot;here let me thread that for you&quot;, :frank=&gt;&quot;friendly&quot;, :panda =&gt; :zen}
---

Fortunately most programmers will never run in to this issue because of the {} construct, which is more fun anyway.
