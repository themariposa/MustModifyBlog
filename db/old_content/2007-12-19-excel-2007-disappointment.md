---
title: "Excel 2007 Disappointment"
layout: 'post'
permalink: 2007/12/19/excel-2007-disappointment
published: 2007-12-19 06:48:00 UTC
---
What an embarassment.

!http://bp1.blogger.com/_VeJd3vmTCZg/R2kz0GpS6uI/AAAAAAAAEhc/HoLxuK_1hkE/s320/excel_pathetic.png! 
It was recently pointed out to me that, by default, Excel 2007 will not let you open two files with the same name that are stored in different folders.

Take these two files for example:
c:\source\projects\my_project\documentation\authentication\test_plan.xlsx
c:\source\projects\my_project\documentation\time_entry\test_plan.xlsx

If you tried to open both, you would receive the message &quot;you cannot open two documents with the same name, even if the documents are in different folders.&quot;

I found a thread about the &quot;duplicate filename problem in Excel 97 and 2000&quot;:http://www.anetforums.com/posts.aspx?ThreadIndex=17869 . Unfortunately, their fix didn't work for Excel 2007. I guess that even bugs can be refactored sometimes. Their solution did give me an idea, though... here's what I did to stop it. I have not experienced any negative side effects, but I am no expert on DDE. &quot; !http://bp0.blogger.com/_VeJd3vmTCZg/R2kym2pS6tI/AAAAAAAAEhU/e56U0ejPxj8/s200/ScreenShot017.png! &quot;:http://bp0.blogger.com/_VeJd3vmTCZg/R2kym2pS6tI/AAAAAAAAEhU/e56U0ejPxj8/s1600-h/ScreenShot017.png 

* Press [Win]E Tools &gt; Folder Options &gt; File Types
* find and select the entry for &quot;xlsx&quot;
* click &quot;Advanced&quot;
* select &quot;Open&quot;
* click &quot;Edit&quot;
* remove the &quot;DDE Message&quot; (highlighted at right)
* at the end of the &quot;Application used to perform action&quot; field, change
 *%1* to *&quot;%1&quot;* 

for me, this field now has this value:

&quot;C:\Program Files\Microsoft Office\Office12\EXCEL.EXE&quot; /e &quot;%1&quot;

The value in this field is the DOS command-line syntax used to open the file. %1 is the filename for the document being opened. %1 needs to be encased in quotes to accomodate spaces in file names. It tells Excel that the value that will replace %1, even if it contains spaces, does not stop until the final quote.
