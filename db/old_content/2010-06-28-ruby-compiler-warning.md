---
title: "Why Ruby Complains about Nested Parentheses "
layout: 'post'
permalink: 2010/06/28/ruby-compiler-warning
published: 2010-06-28 11:50:57 UTC
---
Every time a dev asks me why Ruby doesn't like nested arguments without parens, I draw a blank, but I swear that it's an issue.

Here's an example of the issue:

--- ruby
=link_to h @person.philosophy, @person.philosophy
---

it seems really obvious right now. I'm not sure why I can't think of that when it's clinch time. Anyway, this can be the obviously intended call:

--- ruby
=link_to( h( @person.philosophy ), @person.philosophy )
---

or the unfortunate( and invalid, since h takes 1 not 2 arguments )

--- ruby
=link_to( h( @person.philosophy, @person.philosophy ))
---


