---
title: "Misys Tiger via ODBC via C#"
layout: 'post'
permalink: 2012/11/07/misys-tiger-via-odbc-via-c
published: 2012-11-07 16:31:38 UTC
---
The code below constitutes my various attempts to connect to Misys Tiger via ODBC using C#. Feel free to skip to the word &quot;WiN&quot; to skip the failures.

h3. Warning

This code below is not inteded to be production-worthy. I just wanted to see data. Excuse the slop.

h2. Questions and Answers

Q. How do I create a connection to the various ODBC connections available?

A. see &quot;#WIN&quot; below.

Q. How can I retrieve data from this connection? Some examples found online fail for this connection.

A. see &quot;#WIN&quot; below.

Q. How should I handle the numerous errors that can come from the ODBC connection?

Q. My client's installation of Tiger has many companies. Each company has its own ODBC connection. ( Company_0001, Company_0002, Company_0012, ... ). Each time I esablish a connection to a new company, a dialog asks the user to authenticate. Can I make it so that the user only has to sign in once?

A. The ODBC connection respected the username and password when embedded in the connection string:

---
DSN=Company_0001;Uid=username;Pwd=password
---


h2. ADO.NET with DataAdapter - #FAIL

---
		public class CompanyListFactory
		{
			public static DataSet Get()
			{
				OdbcConnection _connection = new OdbcConnection(&quot;DSN=Company_Shared&quot;);
				_connection.Open();

				DataSet ds = new DataSet();
				OdbcDataAdapter query = new OdbcDataAdapter( &quot;select * from root.COMPANY_APC&quot;, _connection );
				query.Fill( ds );
				
	            _connection.Close();				
  				return( ds );
			}
		}
---

I get this error:

---
System.Data.Odbc.OdbcException: ERROR [IM001] [Microsoft][ODBC Driver Manager] Driver does not support this function
   at System.Data.Odbc.OdbcDataReader.NextResult(Boolean disposing, Boolean allresults)
   at System.Data.Odbc.OdbcDataReader.NextResult()
   at System.Data.ProviderBase.DataReaderContainer.NextResult()
---

I suspect this is a valid error because when I change the table name to COMPANY_XYZ I get:

---
[Transoft][TSODBC][usqlsd]Unknown Table 'root.COMPANY_XYZ'
---

After reading about ODBC compliance, I suspect the OdbdDataAdapter is issuing commands that include pagination, etc., which perhaps the Transoft driver may not respect.

h2. ODBC Compliance

In a previous, aborted attempt to connect, I got this error:

---
System.Data.Odbc.OdbcException: ERROR [01000] [Microsoft][ODBC Driver Manager] The driver doesn't support the version of ODBC behavior that the application requested (see SQLSetEnvAttr
---

which led me to the understanding that there are levels of ODBC conformance. Microsoft is assuming they are using the &quot;we are awesome&quot; level of ODBC... but it seems more likely that they are using the &quot;bare minimum necessary&quot; level of ODBC. At this point what I want is to go back to the ADODB model... &quot;I send you a select, you send me back raw data&quot; model, rather than the &quot;Let's have handlers and all kinds of levels of abstraction&quot; model.

*Update*

The &quot;Transoft U/SQL Help Document&quot;:ftp://ftp2.transoft.com/pub/CDextras/USQL/documentation/Transoft_USQL_Help.pdf provides a relevant table starting around page 70. This document even provides C# example code on page 113 ! 

h2. Using COM component, just like the example: #FAIL
---
		public void UseComComponent()
		{
			ADODB.Connection conn = new ADODB.Connection();
			conn.Open(&quot;DSN=Company_Shared&quot;);
             String sql = &quot;select 'A' from root.COMPANY_APC&quot;;
            
			ADODB.Recordset rs = new ADODB.Recordset();
			rs.CursorLocation = ADODB.CursorLocationEnum.adUseServer;
			rs.Open(sql, conn, ADODB.CursorTypeEnum.adOpenForwardOnly, ADODB.LockTypeEnum.adLockReadOnly);
			object zz = rs.GetRows();

			while( rs.EOF != true )
			{
				Console.Write(rs.DataMember);
				rs.MoveNext();			
			}

            	
			conn.Close();
		}
---

An example I have been referencing was written in VB, so it used COM components intead of the CLR. I added a reference to the COM component &quot;Microsoft ActiveX Data Objects 2.7 Library&quot; (which the author of that post also used). That gave me ADODB. I was able to get pretty far, but couldn't quite figure out how to get the data out of the reader:


h2. using ADO.NET's DataReader -- #WIN !!!

---
/* some of these aren't necessary, don't remember which. */
using System
using ADODB;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Data;
using System.Data.Odbc;

		public void UseAdo()
		{

			OdbcConnection _connection = new OdbcConnection(&quot;DSN=Company_Shared&quot;);
			_connection.Open();
			OdbcCommand cmd = new OdbcCommand(&quot;select 'A' from root.COMPANY_APC&quot;, _connection);
			OdbcDataReader reader = cmd.ExecuteReader();
			Console.WriteLine(&quot;JW Was Here&quot;);
			if(reader.HasRows)
			{
				while(reader.Read())
				{
					string s = reader.GetString(0);
				}
			}
			
            _connection.Close();	
		}
---

Even though I had already failed to use ADO.NET, I tried again. This time I found an article that went into great detail about various ways to retrieve data.

h2. Various Errors Experienced, some solved.

h3. Another Computer, Another Error

I built a spike and took it to another computer, running XP instead of Windows 7. I got this error:

---
ERROR [01000] [Microsoft][ODBC Driver Manager] The driver doesn't support the ve
rsion of ODBC behavior that the application requested (see SQLSetEnvAttr).   at
System.Data.Odbc.OdbcConnection.HandleError(OdbcHandle hrHandle, RetCode retcode
)
   at System.Data.Odbc.OdbcConnectionHandle..ctor(OdbcConnection connection, Odb
cConnectionString constr, OdbcEnvironmentHandle environmentHandle)
   at System.Data.Odbc.OdbcConnectionOpen..ctor(OdbcConnection outerConnection,
OdbcConnectionString connectionOptions)
   at System.Data.Odbc.OdbcConnectionFactory.CreateConnection(DbConnectionOption
s options, Object poolGroupProviderInfo, DbConnectionPool pool, DbConnection own
ingObject)
---

My initial reading of this is that it tried to open a connection and one of the commands issued failed(?). I opened Misys Query on this machine and re-ran it. Successful connection. I closed Misys Query and the program continued to work. My suspicion is that Misys Query is creating ODBC connections that aren't there when the computer first starts. Needs further research.

h3. Can not use DataTable.Load( DataReader_instance )

Interesting sidenote: When I put a breakpoint at DataTable.load( reader ), and then I step past it, I get nothing instead of this error.

---
ERROR [IM001] [Microsoft][ODBC Driver Manager] Driver does not support this func
tion   at System.Data.Odbc.OdbcDataReader.NextResult(Boolean disposing, Boolean
allresults)
   at System.Data.Odbc.OdbcDataReader.NextResult()
   at System.Data.DataTable.Load(IDataReader reader, LoadOption loadOption, Fill
ErrorEventHandler errorHandler)
---

h2. References

&quot;AllScripts Tiger to MS SQL using GoDaddy Hosting&quot;:http://pcnorb.blogspot.com/2010/02/allscripts-tiger-to-ms-sql-to-godaddy.html
&quot;ADO.NET code samples&quot;:http://msdn.microsoft.com/en-us/library/dw70f090.aspx
&quot;ADO.NET for ADO Programmers&quot;:http://msdn.microsoft.com/en-us/library/ms973217.aspx
&quot;Retrieving Data Using the DataReader&quot;:http://msdn.microsoft.com/en-us/library/aa720705.aspx
&quot;DSN Connection String Samples&quot;:http://www.connectionstrings.com/dsn
&quot;Transoft U/SQL Help Document&quot;:ftp://ftp2.transoft.com/pub/CDextras/USQL/documentation/Transoft_USQL_Help.pdf
