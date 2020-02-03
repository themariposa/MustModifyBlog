---
title: "installing rubinius + puma on EC2 with Amazon Linux"
layout: 'post'
permalink: 2013/10/24/ops-rubinius-puma-ruby
published: 2013-10-24 15:43:55 UTC
---
I have been struggling to get this to work, so I thought I would start fresh and write down the process in order to avoid making random decisions.

h2. Overview
# install rubinius
# install bundler
# install MySQL
# cap deploy:setup
# cap deploy
# puma . # see it work at all
# get puma to run as a service

h2. Install Rubinius

options:
* install MRI and then install Rubinius
* install Rubinius via rvm, chruby, rbenv, etc.

I use rvm in dev. I honestly don't know the implications of running rubinius / puma via rvm, chruby, etc., and was not able to get any useful information from #rubinius. For now, since I'm comfortable with it, I'm going with rvm.

h2. get puma to run as a service

wget https://raw.github.com/puma/puma/master/tools/jungle/init.d/puma


h2. References

&quot;Gist: 'Puma + Nginx + Capistrano'&quot;:https://gist.github.com/natew/6207594
&quot;Puma as a Service&quot;:
