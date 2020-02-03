---
title: "regenerating httpd.include from capistrano with sudo"
layout: 'post'
permalink: 2009/11/19/regenerating-httpdinclude-from
published: 2009-11-19 08:23:00 UTC
---
As a general rule, if you need to do something with sudo in your cap scripts, and you don't know why that might be a bad idea, something has gone wrong. I recently ran in to an exception. For various reasons, we need to auto-generate our httpd.include file after deploying to production.

note: command names have been change to protect me from unknown risks. :)

Anyway, here's how I got it to work with a minimum of fuss:

In order to generate the httpd.include file, we need to run a command.

---
sudo /usr/sbin/whatever -a
---

which will then generate my httpd.include file. Previously, the account used by capistrano, 'deployer', did not need sudo access, but there doesn't seem to be a way around it in this situation. I assumed (possibly incorrectly) that capistrano would not be able to handle entering the sudo password, so my goal was to give sudo access to 'deployer', but only for this one file, and without having to enter a password.

---
[jwright@server ~]$ sudo visudo
---

and I added this line:

---
deployer ALL=NOPASSWD: /usr/sbin/whatever
---

then I SSH'd in using the deployer user and verified that it could execute that file with sudo access without typing a password. I still need to consider the implications of this user editing that file...

so then in capistrano:

---
desc 'autogenerate httpd.include file'
task :generate_httpd, :roles =&gt; :app do
run &quot;sudo /usr/sbin/whatever -a&quot;, :pty =&gt; true
end
---
alternately, I could have done this:
---
pre.desc 'autogenerate httpd.include file'
task :generate_httpd, :roles =&gt; :app do
run &quot;#{current_path}/script/autogenerate_httpd&quot;, :pty =&gt; true
end
---
which might be a good idea just so I don't have to remember the command if I want to auto-generate it when I'm SSH'd in at some point...

Either way, the :pty=&gt;true apparently is necessary to run sudo, and it somehow relates to the fact that sudo typically asks for a password. That this one command doesn't require the password seems to be irrelevant.
