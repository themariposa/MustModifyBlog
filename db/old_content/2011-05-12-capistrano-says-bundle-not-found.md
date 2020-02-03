---
title: "Capistrano says, \"sh: bundle: not found\""
layout: 'post'
permalink: 2011/05/12/capistrano-says-bundle-not-found
published: 2011-05-12 12:52:35 UTC
---
Typically, you define your path in /etc/environment. Here's a simple example:

---
PATH=&quot;/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/ruby/bin&quot;
---

That last bit tells the system where Ruby lives. If Ruby isn't in the path, you won't be able to run it or any gem scripts, like bundle.

Unfortunately, neither /etc/environment nor /etc/profile is respected under certain situations, like the way Capistrano works by default.  

The solution for me was to edit /etc/bash.bashrc, adding this as the first line:

---
  source /etc/environment
---

Note: Adding it as the first line allows / encourages it to be overwritten as needed. If you're still having problems, here's one way to get started with troubleshooting:

edit /etc/bash.bashrc to include this
---
  export USES_BASHRC='bashrc'
---

edit /etc/profile to include this line:
---
   export USES_PROFILE = 'profile'
---

then see whether either of those environmental variables is around when capistrano connects. From your dev machine, run &quot;cap shell&quot; and you will end up with a &quot;cap&gt;&quot; prompt. type &quot;echo $USES_BASHRC &amp;&amp; echo $USES_PROFILE. Here's what I got:

---
   cap&gt; echo $USES_BASHRC &amp;&amp; echo $USES_PROFILE
   [establishing connection(s) to www.verdacom.com] 
   Password:
    ** [out :: www.verdacom.com] bashrc
    ** [out :: www.verdacom.com]
---

Thanks to the SliceHost support team for pointing me in the right direction on this one.

REFERENCES
============
http://stefaanlippens.net/bashrc_and_others
