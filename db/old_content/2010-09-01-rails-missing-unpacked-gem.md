---
title: "Rails says, \"Missing pdf-writer\" when pdf-writer is unpacked in vendor/gems"
layout: 'post'
permalink: 2010/09/01/rails-missing-unpacked-gem
published: 2010-09-01 09:07:51 UTC
---
Issue:
*&quot;Missing these required gems: pdf-writer = 1.1.8&quot;*

config/environment.rb:
---ruby
  config.gem &quot;pdf-writer&quot;, :lib =&gt; &quot;pdf/writer&quot;, :version =&gt; '1.1.8'
---

That looks write... what's the issue? Turns out my new server didn't have the required dependencies.

I added this above the config/gem line:

--- ruby
  require &quot;#{RAILS_ROOT}/vendor/gems/pdf-writer-1.1.8/lib/pdf/writer.rb&quot;
---

and saw:

---
  no such file to load -- color
  no such file to load -- transaction-simple      # after fixing color
---

the fixes:
---
  gem install color
  gem install transaction-simple
---

remove the require line, and voila!

