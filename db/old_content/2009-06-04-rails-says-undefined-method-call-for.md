---
title: "Rails says, \"Undefined method 'call' for SomeController\""
layout: 'post'
permalink: 2009/06/04/rails-says-undefined-method-call-for
published: 2009-06-04 14:12:00 UTC
---
20 minutes of my life were lost because I hand-generated a controller.

If your controller looks like this:

---ruby
class SomeController
end
---

it should look like this:

---ruby
class SomeController &lt; ApplicationController
end
---

:)
