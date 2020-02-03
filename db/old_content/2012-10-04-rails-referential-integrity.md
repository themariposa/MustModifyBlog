---
title: "The Somewhat-Extremely-Helpful inverse_of Option"
layout: 'post'
permalink: 2012/10/04/rails-referential-integrity
published: 2012-10-04 18:33:23 UTC
---
Let's say you have the following association set up:

---
class Route &lt; ActiveRecord::Base
  has_many :appointments, :inverse_of =&gt; :route
  # long live the hash rocket!
end

class Appointment &lt; ActiveRecord::Base
  belongs_to :route, :inverse_of =&gt; :appointments
end
---

the 'inverse-of' option is supposed to prevent unneeded queries.

If you ask a route for one of its appointments, and then ask that appointment for its route, there's no need to issue a query... the route is already in memory. Without inverse_of, though, it will go to the db. Say it with me boys and girls, &quot;Lack of referential integrity.&quot;

---
&gt;&gt; r = Route.find 10

  Route Load (0.2ms)   SELECT * FROM `routes` WHERE (`routes`.`id` = 10)

&gt;&gt; a = r.appointments.first

  Appointment Load (1.2ms)   SELECT * FROM `appointments` WHERE (`appointments`.route_id = 10) 

&gt;&gt; a.route

  Route Load (0.2ms)   SELECT * FROM `routes` WHERE (`routes`.`id` = 10)
---

WHERE IS MY AWESOMENESS????

It turns out this only works if you use array indexes.

---
&gt;&gt; r = Route.find 10

  Route Load (0.2ms)   SELECT * FROM `routes` WHERE (`routes`.`id` = 10)

&gt;&gt; a = r.appointments[0]

  Appointment Load (1.2ms)   SELECT * FROM `appointments` WHERE (`appointments`.route_id = 10) 

&gt;&gt; a.route

  Route Load (0.2ms)   SELECT * FROM `routes` WHERE (`routes`.`id` = 10)
---

h2. References

&quot;inverse_of not working with has_many&quot;:https://github.com/rails/rails/issues/3223
