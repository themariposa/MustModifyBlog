---
title: "cucumber says, \"no such file to load -- spec/expectations\""
layout: 'post'
permalink: 2011/09/13/cucumber-says-no-such-file-to-load-spec-expectations
published: 2011-09-13 17:01:12 UTC
---
Setting up a Rails3 application quickly, I ran in to this error... 

no such file to load -- spec/expectations

easy fix... I had gem 'rspec' but needed to add gem 'rspec-rails'
