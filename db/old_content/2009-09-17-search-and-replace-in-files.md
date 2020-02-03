---
title: "search and replace in files"
layout: 'post'
permalink: 2009/09/17/search-and-replace-in-files
published: 2009-09-17 11:03:00 UTC
---
For all files under app/views, replace all tabls with two spaces.
---
find app/views -type f -print0 | xargs -0 sed -i 's/\t/ /g'
---

broken down:

---
find app/views -type f
---

'find' lists all the files (with relative path) at or below the specified path. 'type -f' gives you 'files' ie not directories. It also exclude symlinks, etc. [ see &quot;list of file types&quot;:http://www.gnu.org/software/findutils/manual/html_mono/find.html#index-g_t_002dtype-31 ]

'-print 0' is a hack for cross-system compatibility issues. [ see &quot;documentation on -print option&quot;:http://www.gnu.org/software/findutils/manual/html_mono/find.html#Print-
File-Name ]

---
xargs -0 ... 
---

xargs simply takes whatever list is passed to it and executes an executable you specify once for each line it receives. the -0 tells xargs to handle the result of find -print0

---
sed -i
---

the -i argument means to edit the file inline... ie overwrite it rather than writing the contents to another file.
&quot; &quot;Danger Will Robinson!&quot;:http://www.entertonement.com/clips/rqfcgvbfmn--Danger-Will-RobinsonRobot-Lost-in-Space- &quot; ... this will rewrite your files ... if you screw this up and aren't using a repository, this could be a disaster for you.

's/needle/replacement/g'

this is the same substitution format as found in vim. replace regex at 'needle' with string 'replacement'. /s is substitute, g is global, ie not just the first occurrence.
