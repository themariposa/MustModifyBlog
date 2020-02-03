---
title: "MySQL says \" Incorrect column specifier for column 'x' \""
layout: 'post'
permalink: 2010/06/28/mysql-says-incorrect-column-specifier-for-column-x
published: 2010-06-28 14:51:17 UTC
---
My rails app uses a database of dubious origin, so I wasn't shocked when I had issues. Because I imported the database from sql, I first noticed the issue when running tests. Tests start with

rake db:test:clone

which starts by regenerating db/schema.rb using

rake db:schema:dump   

My db/schema.rb then contained columns like this:

table.float :somefloat       :limit =&gt; 255

I'm pretty sure you can't have a limit without a precision and scale... in my case, I created this migration:

alter_column :table, :field, :decimal

and everything was golden.
