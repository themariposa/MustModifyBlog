---
title: "MySQL permissions for a Rails app"
layout: 'post'
permalink: 2011/05/21/rails-mysql-permissions
published: 2011-05-21 08:32:20 UTC
---
Here's how I typically setup my rails environments. NOTE: I don't include stored procedure or view permissions because Rails doesn't ever use those. Wouldn't it be great if Rails used views or stored procedures? Actually, I kinda like it the way it is. Stored Procedures are nice but the tradeoff, IE having business logic in the app and in the database, is a high price to pay. As for views, actually, that might be really nice for some reporting things. Maybe that'll be a new gem... :) but for now, stick with these.

DEVELOPMENT MACHINE

I create a dev user and a test machine. For each app, I create app_dev and app_test.

---
CREATE USER test IDENTIFIED BY 'somepass'
CREATE USER test IDENTIFIED BY 'somepass'

GRANT ALL ON app_dev.* to dev;
GRANT ALL ON app_test.* to test;
---

In production I typically have three environments: edge, staging, production. Each has its own database and user.

---mysql
 CREATE USER 'edge'@'localhost' IDENTIFIED BY 'somepass'
 CREATE USER 'staging'@'localhost' IDENTIFIED BY 'somepass'
 CREATE USER 'production'@'localhost' IDENTIFIED BY 'somepass'

 /* note that, counterintuitively,  you do NOT have to */
 /* create these databases first. You can let */
 /* the Rails app do that with rake db:create or whatever. */
 GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX ON app_edge.*
 GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX ON app_staging.*
 GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX ON app_production.*
---

