---
title: "Domain Driven Design (DDD)"
layout: 'post'
permalink: 2007/10/23/domain-driven-design-ddd
published: 2007-10-23 13:25:00 UTC
---
Everyone who has been involved in a large-scale development project, or has any kind of life, inherently knows about Domain specific languages. I knew about them. But until someone pointed out to me that they existed, I hadn't thought specifically about them . So, I was excited to hear it being talked about at the Alt.NET conference, because I really like thinking about things.

Sometimes it's best to talk about things out loud (and or blog about them) to solidify / unify / advance our thought process about core ideas.

From &quot;DomainDrivenDesign.org&quot;:http://www.domaindrivendesign.org/ :

Over the last decade or two, a philosophy has developed as an undercurrent in the object community. The premise of domain-driven design is two-fold:

* For most software projects, the primary focus should be on the domain and domain logic; and
* Complex domain designs should be based on a model.

Domain-driven design is not a technology or a methodology. It is a way of thinking and a set of priorities, aimed at accelerating software projects that have to deal with complicated domains.

The premise should be so should be so ingrained and core-value to a developer that I'm not sure it deserves its own acronym.

Every stakeholder in the application must be using the same language.

example by story

Half of the developers and most of the staff think that a time entry is a group of blocks of time that start when an employee starts their shift, continues through any breaks, and ends when an employee leaves an assigned shift. Some of those blocks will not count toward being paid, others will count. Other developers think that a new time entry starts when someone gets back from lunch.

Corollary: There will be bugs. They will be convoluted to define, test for, and resolve.

The set of all named user types, resources, processes, models, etc., for a project is the Domain. Not having a common language can obviously be the root of massive miscommunication issues.

Here are two domain-specific languages I've experienced, and some of their associated terms. Obviuosly, these words may have meanings outside the domain. Inside the domain, the meanings were specific, uniform, pervasive, and integral to everything we did.

E Commerce
sale, customer, invoice, receipt, product, category, rating, review, specifications, warranty, catalog, store, drop-shipping, policy, cross-selling, up-selling, attributes, trust-driven, real estate, suggestion-driven, manufacturer-driven, value-driven, and some curse words.

 &quot;Dog Agility
&quot;:http://www.youtube.com/watch?v=0aNE6oKMzIk jump height, hight class, weaves, faults, novice, title, waved-off, touch zone, zoomies, premium, breed, Q

There is more to DDD, but that is the scope of my understanding.

References:

My blog entry on &quot;User Stories&quot;:http://blog.mustmodify.com/2007/10/user-stories.html as explained to me, thunk upon, and re-explained, all within the context of DDD.

 &quot;Domain Driven Design&quot;:http://www.domaindrivendesign.org/ ( I love the .org TLD. It makes the site seem friendly and peace-loving... that deserves a blog entry. )
