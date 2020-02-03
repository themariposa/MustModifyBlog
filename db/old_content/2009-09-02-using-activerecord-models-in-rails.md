---
title: "Using ActiveRecord Models in Rails' routes.rb"
layout: 'post'
permalink: 2009/09/02/using-activerecord-models-in-rails
published: 2009-09-02 13:06:00 UTC
---
I broke the build today by using an ActiveRecord model in my routes file:

--- ruby
dynamic_paths = Model.all.map(&amp;:path)

dynamic_paths.each do |path|
  map.connect path, :controller =&gt; 'feed', :action =&gt; 'show', :format =&gt; 'xml'
end
---

I wouldn't have expected this to be a problem, and it worked immediately, so I went on about my business. Unfortunately, Rails loads the entire Rails environment when it migrates. So, as the build server was migrating, Model.all failed (because the table wasn't there.)

Here is one solution, in the ever-popular and ever-readable &quot;executable comments&quot; style:

--- ruby
def avoiding_migration_issues
   yield if Model.table_exists?
end

avoiding_migration_issues do
  //original code
end
---
