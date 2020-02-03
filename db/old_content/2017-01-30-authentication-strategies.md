---
title: "Authentication Strategies"
layout: 'post'
permalink: 2017/01/30/authentication-strategies
published: 2017-01-30 16:27 CDT
---

Just thinking about all the possible authentication strategies and tokens:

Single Auth Token
-----------------
As a user, I want to authenticate for a single request, no session or authentication persistence, for API purposes or downloads. I assume it was a thing before this, but I was introduced to it by AuthLogic, long may it reign.

Looks like:

```
POST domain.test/invoices.xml?token=sometokenhere

or

GET domain.test/reports/65432.pdf?token=sometokenhere
```

Perishable Token
----------------

As a user, I want to authenticate and create a session using a token that expires (1) on use and (2) after some short lifespan so that I can reset passwords.

This idea also came to me through AuthLogic, long may it reign.

One tricky thing about perishable tokens. You need them to create a session because you're going to (a) show a form and (b) change the password. But some developers might want the user to have to login after resetting the password, and wouldn't want them to see a menu that would allow them to not reset their password. So you have to add some extra logic around being partially authenticated, or allow the perishable token to live past its first use. So that's weird.

Link-Through Authentication
---------------------------

As a lazy user, I want a link in an email to log me in automatically.

Everyone is booing. I hear you. I know, it flies in the face of web security. Banks should avoid this. But I saw it being done by [Motley Fool](https://fool.com) and I think it's a good fit for their audience. Probably older. Probably not tech savvy.

I don't mind it. If you own the email address you own the account, so who cares.

One thing is how long these links should live. Fool.com sends you a one-use link. But there are some very-low-security sites for which auth-until-password-reset might be ok!

Any others?
