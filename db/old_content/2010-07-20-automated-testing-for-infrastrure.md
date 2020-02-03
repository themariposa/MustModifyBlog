---
title: "Automated Testing for Infrastrure"
layout: 'post'
permalink: 2010/07/20/automated-testing-for-infrastrure
published: 2010-07-20 11:11:56 UTC
---
I have a client whose website is subject to HIPAA regulations. I just finished setting up SSL for them. I also set up redirects so that:

http://domain.com =&gt; https://www.domain.com
http://www.domain.com =&gt; https://www.domain.com

It all works now. Unfortunately, I've become accustomed to the feeling of security that I get from automated tests. I can't use rspec here, because that configuration is on the server. I have signed up for monitoring service, but that won't tell me if somehow https://www.domain.com starts serving insecure pages. (most modern browsers will flip, but that doesn't get me around HIPAA.) What if the server crashes, has to be rebuilt, and I forget to set up the SSL stuff? It could be weeks before someone discovers that it isn't there, and that isn't good enough.

Not sure yet what to do.
