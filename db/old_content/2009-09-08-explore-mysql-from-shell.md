---
title: "Explore MySQL from the shell"
layout: 'post'
permalink: 2009/09/08/explore-mysql-from-shell
published: 2009-09-08 09:04:00 UTC
---
I just discovered mysqlshow -- every developer who uses a database should know about this utility. (though I've createded an alias describe, which seems much more intuitive.)

I constantly find myself going into script/console to get a list of the fields for a model, or other db-specific info. This solution is much faster.

given no inputs, it shows a list of databases.
Given a database name, it shows a list of tables.
Given a table name, it describes the fields.

And, since it's in the shell, you have access to grep, etc.

describe.bat looks like this:
---
mysqlshow -u local %1 %2 %3
---

in my sql I created a user &quot;local&quot; and grant select on *.* to local;

describe myapp roles

Enjoy!
