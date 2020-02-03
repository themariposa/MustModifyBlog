---
title: "Evolving thoughts about building APIs"
layout: 'post'
permalink: 2013/10/18/evolving-thoughts-about-apis
published: 2013-10-18 15:47:21 UTC
---
Ever since I saw him speak about the subject at RubyConf 2011, I have been fascinated by Steve Klabnik's ideas about Hypermedia APIs. I have been keeping up with his evolving book on the subject, &quot;Designing Hypermedia APIs&quot;:http://www.designinghypermediaapis.com/ and have enjoyed it.

A new client is asking me to design an API. I started with just the basic REST stuff. Having finished 12 resources, I went to work on the &quot;welcome&quot; page. Steve said that an API should be &quot;fully discoverable&quot;, and I think this concept is great. Basically, a client should be able to go to a site's index page, look for a certain link (just as a human would with a web browser) and then be taken to the relevant resource. If the URLs change around, that shouldn't matter. The API should facilitate that.

So far, my convention has been to include EITHER links to nested resources or to embed nested resources, and include a 'resource' link... so for a building, it might look like this:

---
{
  building:
  {
    resource: '/buildings/3241.json',
    tenants:
    [
      { 
        resource: '/tenants/32342.json'
        name: 'Praeses LLC',
        floors: [4, 5, 8],
        reception: 410,
        lease-resource: '/tenants/32342/lease.json'
      },
      {
        resource: '/tenants/32341.json',
        name: 'Dewey, Cheatum &amp; Howe, Attorneys at Law',
        floor: [7, 8],
        reception: '710',
        lease-resource: '/tenants/32341/lease.json'
      }
    ],
    custodians-resource: '/buildings/3241/custodians.json',
    administrativa-resource: '/buildings/3241/administrators.json',
  }
}
---

so my initial page, the one that has the links to all of the available resources, now looks like this:

---
{
  buildings-resource: '/buildings.json',
  tenant-profile-resource: /tenants/3234.json',
  building-search-resource: '/buildings/search.json',
  user-session-resource: '/user-session.json'
}
---

this is fine, I guess. having a search as a resource might phase some people but I have always looked at search as a resource, so I'm cool with it.

I'm now re-visiting Klabnik's book and also a video of him presenting at a conference in LA. He recommends the following mime-type: collection+json, Cj for short.

The same initial page would look like this in Cj:

---
{
    &quot;collection&quot;: {
        &quot;href&quot;: &quot;/&quot;,
        &quot;items&quot;: [
            {
                &quot;href&quot;: &quot;/users/21001.json&quot;,
                &quot;data&quot;: {
                    &quot;email&quot;: &quot;your-email@some.test&quot;
                }
            },
        ],
        &quot;links&quot;: [
            {
                &quot;name&quot;: &quot;tenant&quot;,
                &quot;href&quot;: &quot;/tenants/3234.json&quot;,
                &quot;rel&quot;: &quot;profile&quot;
            },
            {
                &quot;name&quot;: &quot;tenants&quot;,
                &quot;href&quot;: &quot;/tenants.json&quot;,
                &quot;rel&quot;: &quot;resource&quot;
            },
            {
                &quot;name&quot;: &quot;buildings&quot;,
                &quot;href&quot;: &quot;/buildings.json&quot;,
                &quot;rel&quot;: &quot;resource&quot;
            },
            {
                &quot;name&quot;: &quot;user-session&quot;,
                &quot;href&quot;: &quot;/user_session.json&quot;,
                &quot;rel&quot;: &quot;resource&quot;
            }
        ],
        &quot;queries&quot;: [
            {
                &quot;name&quot;: &quot;buildings-search&quot;,
                &quot;href&quot;: &quot;/buildings/search.json&quot;,
                &quot;rel&quot;: &quot;search&quot;,
                &quot;data&quot;: [
                    {
                        &quot;name&quot;: &quot;q&quot;,
                        &quot;value&quot;: &quot;&quot;
                    },
                    {
                        &quot;name&quot;: &quot;postal_code&quot;,
                        &quot;value&quot;: &quot;&quot;
                    }
                ]
            }
        ]
    }
}
---

The 'items' element should be the result of the current resource... it isn't clear to me whether the current resource is the user, the tenant profile, or the user session... but obviously that would be much more clear for most of the pages.

h3. Some Confusion

The thing that most confuses me here is the use of 'name' and 'rel' for the links. Should I put {name: 'tenant', rel: 'profile', href: '/tenants/3234.json'} and also {name: 'tenant', rel: 'resource', href: '/tenants.json'} ? or is rel additional data where name can be used to find the needed resource? Or should rel be the primary key for finding specific links?

I have heard that the 'rel' tag should describe how the link relates to the current resource. IIRC, I heard someone else suggest that you have a list of rel tags. Something like:

* tenants: the tenant collection resource. 
GET =&gt; list, POST =&gt; create
* new-tenant: gives you the fields needed to create a tenant GET =&gt; read
* tenant: a specific tenant's resource. GET =&gt; read, POST / PATCH =&gt; update, DELETE =&gt; destroy
* tenant-profile: if the current user is associated with a specific tenant, this is a link to that tenant's profile
* user-profile: resource for the current user
* users: user collection resource
* user
* building-search: allows you to create searches and view results. GET/POST =&gt; search. Having search be its own resource allows you to do interesting things like caching search results, and having a page that will return the input fields 
* new-building-search: the page that would return the search fields. For instance, q and zipcode.

h3. Decision Time

So this seems like a lot more fun. I'm about to deploy this app and presumably someone will start building the front-end, so this is the decision point-of-no-return... should I stick with what I have, or start using something like collection+json? 

My big question at this point is *whether it solves a problem I anticipate having* with my current process. 

|Cj feature|can I do it now?|
|list the current resource|yes|
|links to related resources|yes|
|links to parent or unrelated resources|unknown|
|form parameters|yes|
|form options a-la a drop down|no|update: now that I think about it, I can sorta do it. Not as neatly, though.|
|rel tags|no|
|errors|yes|

Although this is a well-thought-out hypermedia mime type, my impression is that it might add some complexity for the client. Complexity is fine, as long as there is a benefit. SOAP, for instance, adds complexity but, in my experience, doesn't provide any benefit over REST in exchange for the complexity.

Looking at this, the only thing that worries me is not having rel tags... though I can't think of an example where that would be a problem. Conclusion: stick with what I have.

h2. References

&quot;Designing Hypermedia APIs&quot;:http://www.designinghypermediaapis.com/
&quot;Collection+JSON Primer (and comments)&quot;:http://schinckel.net/2012/03/10/collection%2Bjson-primer-(and-comments)/
&quot;Collection+JSON support in Roar!&quot;:http://nicksda.apotomo.de/2013/02/collectionjson-support-in-roar/
