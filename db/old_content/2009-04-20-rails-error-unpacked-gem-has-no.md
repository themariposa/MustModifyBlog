---
title: "[Rails error] Unpacked Gem has no specification file."
layout: 'post'
permalink: 2009/04/20/rails-error-unpacked-gem-has-no
published: 2009-04-20 08:58:00 UTC
---
Recently I started working on a new project. Every time I did anything from the command line, I got this irritating error message when rails loaded it's environment: 

config.gem: Unpacked gem [whatever] in vendor/gems has no specification file. Run 'rake gems:refresh_specs' to fix this.

I run rake gems:refresh_specs. I get:

config.gem: Unpacked gem [whatever] in vendor/gems has no specification file. Run 'rake gems:refresh_specs' to fix this.

and the problem isn't fixed.

The &quot;specification file&quot; it wants is, simply, gem_path/.specification

possible solutions:

Go to the original repo to see if you've lost the specification file.

OR

---
cd /vendor/gems/gemname
gem specification authlogic &gt; .specification
---

OR

create a .specification file in the gem's root directory.  As far as I can tell, this is the minimum information necessary:

--- ruby
  --- !ruby/object:Gem::Specification 
  name: gemname 
  version: !ruby/object:Gem::Version
     version: 0.5.2
  require_paths:
  - lib
  platform: ruby
---

HISTORY

2010-04-26 added a solution using 'gem' ... it's much happier than creating your own .spec file because it feels less like guessing. :)

REFERENCES

http://stackoverflow.com/questions/2278847/how-do-i-fix-this-error-config-gem-unpacked-gem-authlogic-2-1-3-in-vendor-gems
