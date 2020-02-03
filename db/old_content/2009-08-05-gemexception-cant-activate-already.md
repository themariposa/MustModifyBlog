---
title: "Gem::Exception: can't activate , already activated x"
layout: 'post'
permalink: 2009/08/05/gemexception-cant-activate-already
published: 2009-08-05 08:59:00 UTC
---
I recently saw this exception:
*[RAILS_ROUTE]* /config/../vendor/rails/railties/lib/rails/gem_dependency.rb:101:in `specification':Gem::Exception: can't activate , already activated *gem_name* 

This exception seemed to be the result of several problems intermingling:

1. rake gems:install wouldn't work because the config.gem statements were in config/environments/test.rb. Only the gems listed in config/environment.rb are installed in gems:install (though I didn't try to manually set the environment to test...)
2. I had the wrong version of nokogiri. The configuration specified a certain version, instead of any version _greater than_ a certain version.
3. I also didn't have the gem listed _after_ the gem with the wrong version. When I modified test.rb so that only the gem with the wrong version was listed, I got a more helpful error:
Missing these required gems: *gem_name = version* 
You're running:ruby 1.8.6.287 at *path* rubygems 1.3.3 at *path* 

So, the solution:
1. Once I found the gem requirements in test.rb, I deleted half of them and ran script/console. I kept deleting chunks of the requirements until the error went away.
2. Installed the correct version
It seems simple in retrospect... but the error was very confusing.
