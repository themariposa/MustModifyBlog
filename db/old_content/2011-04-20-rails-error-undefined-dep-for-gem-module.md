---
title: "[FIX] With Rails 2.3.x, undefined local variable or method `dep' for Gem:Module "
layout: 'post'
permalink: 2011/04/20/rails-error-undefined-dep-for-gem-module
published: 2011-04-20 09:44:46 UTC
---
I received this message when I ran cucumber tests but not when I used script/console. Kinda strange. Perhaps this is because I didn't configure cucumber for my dev environment?? Anyway, the fix:

---
gem uninstall rubygems-update
gem update --system 1.4.3
---

In the words of Yoda, &quot;Unfortunate this is, and unexpected.&quot;

References
=======
&quot;Can not install redmine&quot;:http://www.redmine.org/boards/2/topics/23318?r=23322
&quot;Gist -- Undefined local variable dep&quot;:https://gist.github.com/901775
&quot;RubyGems Developers Mailing List&quot;:http://www.mail-archive.com/rubygems-developers@rubyforge.org/msg04579.html
&quot;StackOverflow -- How do you downgrade RubyGems&quot;:http://stackoverflow.com/questions/523993/how-do-you-downgrade-rubygems

