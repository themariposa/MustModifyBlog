---
title: "Getting data into production shouldn't be a blocker. But it is. Again."
layout: 'post'
permalink: 2009/09/10/getting-data-into-production-shouldnt
published: 2009-09-10 06:33:00 UTC
---
I can think of at least three Rails projects recently where one of the blockers to being really ready to get a project into production was a lack of production data. I'm on a project right now that is code-complete and has been for more than week. We have a production machine configured and ready to rock. The only thing that prevents us from moving the DNS records over to the new machine is a lack of production data.

Some of this involves uploading images. I'm not sure that should be part of a repository, so that may be a legitimate holdback. Other data, though, was an issue and shouldn't have been. For instance, I had to ssh into the production machine to create an admin user.

How did we get to this point?

We used fixtures to populate our dev and staging servers. It was a great solution to the pain-point of populating the data before going live, but now the pain point is back. Often t fixture data is not appropriate / sufficient for production. Even if we populated production from fixtures, this could only happen once, though there will be many times in the life of an application where loading data will be necessary. We knew we needed data, had the data, and didn't do anything to automate adding it to the db.

This has obviously been an issue for others. The Rails team has recently added db/seeds.rb. Others have tried this solution and are happy with it. I would prefer a solution that would 'grow with the application', populating new tables as they are created. At the same time, I don't want to polute the migrations with data. (It isn't a very effective solution anyway, as this data would be destroyed for tests, which then would not be DRY.)

*IDEAS*

---
RAILS_APP/db/seeds/20090909090909_add_users.rb
rake db:seed
---

*PROS*
- could grow with the application
- could be run just as easily as rake db:fixtures:load
- could be added to a capistrano recipe

*CONS*
- isn't written yet

**Existing Solutions**
- &quot;seed_fu&quot;:http://github.com/mbleigh/seed-fu/tree/master 
- &quot;db-populate&quot;:http://github.com/ffmike/db-populate/tree/master - this seems pretty close to what I have in mind.


I'm going to continue to think on this one and hopefully do something about it soon.
