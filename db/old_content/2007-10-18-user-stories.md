---
title: "User Stories"
layout: 'post'
permalink: 2007/10/18/user-stories
published: 2007-10-18 11:58:00 UTC
---
At the &quot;Alt.NET&quot;:http://www.altnetconf.com/ conference in Austin, I was fortunate enough to hear about the idea of generating user stories . Although this was entirely new to me, it was immediately clearthat this was a very effective way to create a spec. It also provides a very convenient and organized way to create functional requirements and test plans.

The concept of user stories was laid out within the context of &quot;Domain Driven Design (DDD)&quot;:http://blog.mustmodify.com/2007/10/domain-driven-design-ddd.html . I don't think user stories could be effective without a pervasive domain-specific vocabulary.

Overview

The process of developing specifications using user stories is simple. We're break down a project hierarchically. These stories are the central source of knowledge about the application and should be available to all stakeholders for review / validation. No one stakeholder should make changes without buy-in from the other stakeholders.

Here is the basic hierarchy:

Projects have Epics. Epics have Episodes. Episodes have User Stories. User Stories have Functional Requirements. Functional Requirements dictate Test Plans.

This is a tree structure. If you have a test plan that doesn't fit a functional requirement, either it is an invalid test or there is a functional requirement missing. If you have a functional requirement without a user story, again, something has gone wrong. This works all the way up to a signal root node.

Epics

An Epic is a main functionality of the software. Sometimes, these are called modules. If you were writing software to manage a hospital, an Epic might be Payroll. Another might be Patient Care. These can share some domain information, like nurses and patients, but will not share others, like Job Type, Employment Date, etc.

Episodes

Episode is a subset of an Epic. If an Epic is Payroll, an Episode might be Employee Maintenance, Vacations, etc., etc. If an Episode &quot;feels&quot; too big, it should be broken down.

[UPDATE: Just found my notes from alt.net -- they were using the word &quot;themes&quot; instead of &quot;episodes&quot;. It's arbitrary; run with it.]

User Stories

A user story should describe a specific experience of a person using the application. It should take the form of a sentence with three sections:

As a _ _____________ ( type of user )
I want to _____________ ( some action )
so that ________________. ( business value )

From the discussion in which I participated, it was clear that this format was great a promoting good communication between all stakeholders. By limiting the scope to a single experience at a time, it also decreases the need for changes later. User stories should make heavy use of domains-specific languages.

The scope must be kept in check: It should be a bite-size chunk of functionality, taking no more than 20 hours to develop.

Examples of user stories:
bq{font-style: italic;}. As a case worker, I need to pull the next case out of my queue so that I can mark it as being worked and add information to it.

As a customer, I need to be able to enter my personal information so that the company can search for my account or contact me.

As a company executive, I need to see daily reports on employee productivity so that I can manage the company's resources and my clients' expectations.

About Vocabulary

Be sure to use domains-specific words at every level of this process. This includes User Stories, Acceptance Tests, and the names of your test cases. Remember, this is about users' experiences, not code. The code is based on the experience, not the other way around. The following words are banned : null, table, validate, error, loop, id (there may be more.) By avoiding these technical words in your specifications, you invite the participation of every stakeholders. The word Model is allowed. Apparently non-technical people understand that things can be modeled.

References

Here is &quot;Scott Bellware's brain-dump about User Stories&quot;:http://codebetter.com/blogs/scott.bellware/archive/2007/10/22/170065.aspx . Scott works at &quot;Dovetail Software&quot;:http://www.dovetailsoftware.com/ , which was &quot;500 feet&quot; from the conference. We visited their office after discussing user stories and saw their notecards neatly organized on the board. I've got some pictures of that somewhere... Scott, do you seriously need a 40 inch monitor?

Conclusions

This is a powerful, efficient way to create a specification, to keep your stakeholders engaged in your project and its development, to build a consensus when the stakeholders have disagreements and to ensure that communication is at a maximum.

