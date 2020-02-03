---
title: "1.day Ruby's case operator === behaved badly"
layout: 'post'
permalink: 2009/05/29/1day-rubys-case-operator-behaved-badly
published: 2009-05-29 09:01:00 UTC
---
This is a follow-up to a previous post about the Ruby case operator, ===.

I previously understood that, for a === b where a is a class, the result would be b.class.ancestors.include?(a)

when a is an instance, the result would be a == b

This proves true for many examples.

---ruby
&gt;&gt; 3.class.ancestors.all? {|a| a === 3}
=&gt; true
---

So I was very suprised to find this:

---ruby
&gt;&gt; 3.days.class
=&gt; Fixnum

&gt;&gt; Fixnum === 3.days
=&gt; False

&gt;&gt; 3.days.class.ancestors.include?(Fixnum)
=&gt; true
---

---ruby
def days
  ActiveSupport::Duration.new(self * 24.hours, [[:days, self]])
end
---

And, in fact:
---ruby
  &gt;&gt; ActiveSupport::Duration === 3.days 
  =&gt; true
---

 I'm not clear on why this happens. I'll update this post as it becomes clear.
