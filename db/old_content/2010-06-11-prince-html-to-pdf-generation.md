---
title: "Getting started generating PDFs with Prince"
layout: 'post'
permalink: 2010/06/11/prince-html-to-pdf-generation
published: 2010-06-11 10:15:15 UTC
---
Download and uncompress Prince:

---
jw@gallifrey:~$ curl http://www.princexml.com/download/prince-7.1-linux.tar.gz -o prince.tar.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 3879k  100 3879k    0     0   763k      0  0:00:05  0:00:05 --:--:--  940k
jw@gallifrey:~$ tar -xzf prince.tar.gz
jw@gallifrey:~$ cd prince-7.1-linux/
jw@gallifrey:~/prince-7.1-linux$ ls
jw@gallifrey:~/prince-7.1-linux$ install.sh  lib  LICENSE  README
jw@gallifrey:~/prince-7.1-linux$ sudo ./install.sh
Prince 7.1

Install directory
    This is the directory in which Prince 7.1 will be installed.
    Press Enter to accept the default directory or enter an alternative.
    [/usr/local]:

Installing Prince 7.1...
Creating directories...
Installing files...

Installation complete.
    Thank you for choosing Prince 7.1, we hope you find it useful.
    Please visit http://www.princexml.com for updates and development news.

---

Based on the &quot;documentation&quot;:http://dev.physioagereporting.com/sample.pdf

jw@gallifrey:~/prince-7.1-linux$ prince http://app.local/reports/my_report.html  -o /code/client/app/public/sample.pdf

IT WORKS! but it's kinda ugly.

add pdf.css based on the &quot;boom microformat&quot;:http://www.alistapart.com/articles/boom/ ...
add .cover-page, .chapter, .cover-notes, etc

---css
@page {
  size: 8.5in 11in;
  margin: 0.75in;
}

p, .cover-notes {
  line-height: 1.7em;
}

.titlepage, div.chapter, div.appendix {
  page-break-after: always;
}

.titlepage {
  page: blank;
  margin: 1in 0.75in 0.75in;
  text-align: center;
}

.document-heading {
  font-size: 0.5in;
  padding: 1in 0;
}

.cover-notes{
  font-size: 0.3in;
}

h1, h2, h3, h4, h5, h6 {
  page-break-after: avoid;
}

h1 {
string-set: document-heading content();
}

h2 {
string-set: chapter-heading content();
}

q::before {
  content: &quot;\201C&quot;;
}

q::after {
  content: &quot;\201D&quot;;
}

/* This can be alternated so that left and right facing pages are opposites; In my case, this isn't useful, so I merged it to one. */

@page {
  @top-left {
    content: string(document-heading, first);;
  }
  @top-right {
    content: string(chapter-heading, first);
  }
  @bottom {
    content: counter(page);
  }
}

/* don't show document title in the heading on the cover page. */
@page blank :right {
  @top-left {
    content: normal;
  }
}
---

jw@gallifrey:~/prince-7.1-linux$ prince http://app.local/reports/my_report.html -s http://app.local/stylesheets/pdf.css -o /code/client/app/public/sample.pdf



jw@gallifrey:~$ 
jw@gallifrey:~$ sudo gem install princely
Successfully installed princely-1.2.5
1 gem installed

---

