---
title: "get Ruby 1.9 Date.parse to assume American date format"
layout: 'post'
permalink: 2011/03/29/get-ruby-1-9-date-parse-to-assume-american-date-format
published: 2011-03-29 08:04:59 UTC
---
Ruby 1.9 assumes that everyone has been broken of the bad habit of illogical date formats.

in the console:

---
&gt;&gt; Date.parse('2/15/2011')
ArgumentError: invalid date

&gt;&gt; Date.parse('2/15/11')
ArgumentError: invalid date

&gt;&gt; '2/15/2011'.to_date
ArgumentError: invalid date
---

While I'm driving everyone crazy by writing the date as YYYY-MM-DD, my clients aren't as OCD. They insist on using the American date format mm/dd/yyyy and it's lazy alternate, mm/dd/yy. Here's the code I wrote to help them with their bad habits.

For my rails apps, in config/initializers/american_date_format.rb:

---ruby
  def Date.parse(value = nil)
    if value =~ /^(\d{1,2})\/(\d{1,2})\/(\d{2})$/
      ::Date.civil($3.to_i + 2000, $1.to_i, $2.to_i)
    elsif value =~ /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/
      ::Date.civil($3.to_i, $1.to_i, $2.to_i)
    else
      ::Date.new(*::Date._parse(value, false).values_at(:year, :mon, :mday))
    end
  end
---

Now:

---
&gt;&gt; Date.parse('2/15/11')
=&gt; Tue, 15 Feb 2011

&gt;&gt; Date.parse('2/15/2011')
=&gt; Tue, 15 Feb 2011

&gt;&gt; Date.parse('2011-02-15')
=&gt; Tue, 15 Feb 2011

&gt;&gt; '2011-02-15'.to_date
=&gt; Tue, 15 Feb 2011

&gt;&gt; '2/4/11'.to_date
=&gt; Fri, 04 Feb 2011
---
