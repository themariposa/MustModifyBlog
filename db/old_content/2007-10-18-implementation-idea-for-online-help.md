---
title: "Implementation Idea for Online Help"
layout: 'post'
permalink: 2007/10/18/implementation-idea-for-online-help
published: 2007-10-18 07:52:00 UTC
---
About a year ago, I was tasked with creating a help system. I sat down, ready to pour out my astounding wit into a document that would enable users to achieve the path to enlightenment. Unfortunately, I came to as realization. I realized that I didn't know what the end users would want to know. After talking to some other developers and cogitating, I've come up with what I think is a great help system for a website. It has these goals:

* Context Sensitive. Tells you what you need to know when you need to know it.
* Intelligently display the most useful (used) information
* Make it convenient for users to find/read and authors to add/update
* Easy to Implement


Enabling Users

Your users are a lot more familiar with what confuses them than you are. If your help document doesn't cover their needs, allow them to submit questions. Also allow competent users to answer those questions. In addition to providing users with relevant help, you're encouraging a sense of community around your software.

Given the varying levels of user sophistication, grammar, organization and technical writing skills, I think a WIKI format might be the wrong idea here. However, going with something like php.net's &quot;Add a comment&quot; format would be very easy to implement, easy to review, and would allow users to post notes about what confused them.

Remember, no one actually clicks &quot;Help.&quot;

Never may be a bit strong, but a &quot;help&quot; button is essentially putting your users farther away from information they need. Sure, the thick manual really helps to sell the software to big companies; but realistically, no one clicks that button. My preference is to add a sidebar to every page with an &quot;About this page&quot; link followed by the top 5 or 10 most viewed or recent Q&amp;A-style topics. This is another opportunity to integrate user-created help by using &quot;New&quot; and &quot;Unanswerd&quot; flags.

Data Mining

One of the biggest benefits of user-generated content is that you can review it. These are actual issues being faced by customers -- not stuff that confused a technical writer. Use this content to understand your users. How are they using your software? Have they found unexpected processes that you can simplify? This sort of reasoning is dangerous because it can lead to better software, and a happiness-feedback-loop is created.Creating great help systems isn't easy, and it isn't cheap. However, this is one of the best ways to increase your returning-user-base over time, because confused users are former users.

Influences

My ideas about help documentation are heavily influenced by &quot;PHP&quot;:http://www.php.net/ 's website. It has the best API I've ever seen. Hands down. Yes, Microsoft's implementation may be more comprehensive, but php.net's is more helpful in terms of actually finding what you need. Three reasons this site is excellent are (a) simple examples of code in use (b) great search tools (c) user contributed comments like, &quot;Hey, if you're having this problem, here is the solution.&quot;
