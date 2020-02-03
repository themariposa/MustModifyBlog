---
title: "Sanity Check: Language Shouldn't Matter"
layout: 'post'
permalink: 2007/10/31/sanity-check-language-shouldnt-matter
published: 2007-10-31 13:43:00 UTC
---
I've been thinking a lot lately about what makes a software project successful. Some of my co-workers at Praeses are fond of discussing the struggles of a certain Ruby project. Since it is certainly a struggling project, and since most projects at Praeses are done in C#, the culprit, the reason for the problems, must be Ruby. Obviously this is a bad assertion, but my question runs a little deeper. &quot;What is the problem?&quot; (or in the case of this project, &quot;What are the problems?&quot;

Patterns&amp;Languages

There is such a divide out there between the religious camps of Rails, J2EE and ASP.net.

The Rails group seeks programming Zen. Clean code = happy code. Tests = happy project goodness. I've talked about Elegant code in Ruby so much that the word &quot;Elegant&quot; has been permanently etched into a list on a whiteboard somewhere as a word that has been banned. It is not allowed to be used any more. I have killed it.

 The C# folk get a sense of security from C#'s solid foundation, it's giant class library, and the fact that it compiles to something that runs really fast. Plus it integrates so easily with SQL Server and other well-designed MS stuff. Type-safe languages can give you a really fulfilling sense of security, and some great intelli-sense.

I haven't programmed in Java, but I imagine that there code is probably an amalgamation of both. I've heard it's a little cleaner, and that there are many fun libraries.

But the thing is, and people who only work in one language will never admit this, they all work. There isn't much you can do in one language that you can't do in the others. Some code is cleaner, some code runs faster, some things are easier in one language or the other.

What really matters is the patterns.
&quot;Good judgment comes from experience, and often experience comes from bad judgment.&quot;
Here's the thing: Stuff that didn't work well last time has a better-than-average chance of continuing not to work well in the future. Things that worked well previously stand a really decent chance of working well again.

Favor composition over Inheritance. Live the Mantra of Separation of Concerns. Dependency Injection reduces Spaghetti. Unit Tests lead to Confidence. These things are much more relevant to whether projects will fail than what language(s) they use.

Embrace Religions Tolerance! Look at the Patterns!
