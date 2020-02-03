---
title: "Ruby Case Statement comparison ... a feature, not a bug :)"
layout: 'post'
permalink: 2008/11/26/ruby-case-statement-comparison-feature
published: 2008-11-26 12:54:00 UTC
---
I accidentally discovered an unintuitive aspect of Ruby case statements. I can't decide whether it's a bug or a feature, or both.

This code results in 'failure'

---ruby
case Integer
when Integer
  'success'
else
  'failure'
end
---

whereas this code results in 'success'

---ruby
case 3
when Integer
  'success'
else
  'failure'
end
---

Ruby uses the === operator for  &quot;case-statement equality&quot;:http://www.pluitsolutions.com/2006/10/09/comparing-equality-eql-equal-and-case-equality-in-ruby/ . When the left-hand is an instance, then it operates as ==. When the left-hand is an object, then the operator returns true if the right-hand.class.ancestors.include?(left_hand). Here are a few examples of the behavior. The value being tested (3, above) is on the right. The values that cause you to fall in to the case (Integer, above) are on the left.

---ruby
&gt;&gt; # These two instances are equal
&gt;&gt; 'hello' === 'hello'
=&gt; true

&gt;&gt; # When the left-hand operand is a Class, then we test whether the right side
&gt;&gt; # is an instance of this class or one of its ancestors, rather than for equality.
&gt;&gt; String === 'hello'
=&gt; true

&gt;&gt; # String is an instance of Object.
&gt;&gt; Object === String
&gt;&gt; true

&gt;&gt; # however, String is not an instance of a String or any of its ancestors.
&gt;&gt; String === String
=&gt; false

&gt;&gt; # That operand also handles other magical behaviors of case statements, such as ranges:
&gt;&gt; (1..10) === 4
=&gt; true
&gt;&gt; (1..10) === 20
=&gt; false
---

UPDATE:
An &quot;exception to this rule&quot;:http://blog.mustmodify.com/2009/05/1day-rubys-case-operator-behaved-badly.html :

---rbuy
&gt;&gt; Fixnum === 3.days=&gt; false
---

