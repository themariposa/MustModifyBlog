---
title: "Rails says, \"SQL Server does not exist or access denied.\""
layout: 'post'
permalink: 2009/01/23/rails-says-sql-server-does-not-exist-or
published: 2009-01-23 10:34:00 UTC
---
Using SQL Server 2005 with Rails 1.2.6, I got the following (less than helpful) error message.
---
      OLE error code:80004005 in Microsoft OLE DB Provider for SQL Server
      [DBNETLIB][ConnectionOpen (Connect()).]SQL Server does not exist or access denied.
      HRESULT error code:0x80020009
      Exception occurred.
---

database.yml:
---yml
development:
  adapter: sqlserver
  database: some_database
  host: my_machine.local
  username: some_username
  password: some_password
---

The Rails driver does this (modified to work in irb):
---ruby
  require 'DBI'
  require 'c:\ruby\lib\ruby\site_ruby\1.8\DBD\ADO\ado.rb'

  ado = DBI::DBD::ADO::Driver.new
  ado.connect( dbname, user, auth, attr )
---

dbname is misleading here for two reasons. First, Rails passes in a connection string. Second, the ADO driver uses it as an odbc name instead of as a host name, etc.  The contents of dbname looked like this:

---
 Provider=SQLOLEDB;Data Source=my_machine.local;Initial Catalog=some_database;User Id=some_username;Password=some_password;
---

THE SOLUTION

In my case, the local SQL Server installation uses a named instance, as opposed to a default instance. I copied the 'server name' field from the login dialog in Sql Server Management Studio, and that worked.
