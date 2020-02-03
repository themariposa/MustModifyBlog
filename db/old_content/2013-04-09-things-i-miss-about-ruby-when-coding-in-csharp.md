---
title: "Things I miss about Ruby when working in C#"
layout: 'post'
permalink: 2013/04/09/things-i-miss-about-ruby-when-coding-in-csharp
published: 2013-04-09 20:18:09 UTC
---
h2. Preface: nil

for those of you who don't know, nil is like NULL, but way cooler. But if you don't know, just pretend it means NULL, but if you ask whether NULL is true or false, it will say, &quot;Oh, yeah, I'm false.&quot; Yes, I know, if you haven't heard of nil this makes you think I'm on crack. Roll with me.

h2. Returning a value or &quot;Sorry, no.&quot;

I miss being able to return either the value OR nil, meaning, &quot;no.&quot; For instance, I have people picking a date from some dropdowns on a form. Then I need to (a) know whether it's a valid date and (b) know what date it is. Ignoring, for a minute, that this problem wouldn't exist in ruby, I could do this.

Note: begin/rescue is ruby's try/catch.

---ruby
def selected_date
  begin
    Date.new( year, month, day )
  rescue InvalidDateError 
  # I have never had to do this so I don't actually know *which* error it would be.**
    nil
  end
end
---

but in C#:
---csharp
		private Boolean specifiedDateValid()
		{
			int year = int.Parse( yearTextbox.Text );
			int month = int.Parse( monthTextbox.Text );
			int day = int.Parse( dayTextbox.Text );
			
			DateTime ignore = new DateTime();
			string datestring = month.ToString() + &quot;/&quot; + day.ToString() + &quot;/&quot; + year.ToString();
			
			return( DateTime.TryParse( datestring, out ignore ) );			
		}


		private DateTime specifiedDate()
		{
			int year = int.Parse( yearTextbox.Text );
			int month = int.Parse( monthTextbox.Text );
			int day = int.Parse( dayTextbox.Text );
			
			return(
				new DateTime( year, month, day ));
		}
---

another example. I'm creating a search method. Search by parameters A, B and C. Well, I decide maybe I will also want the option of searching by A and B. So I'll just leave C blank. But that will make C# flip out... in Ruby, you can just say, &quot;Hey, is that value blank? Or nil? If so, just ignore it&quot;.

h2. Not having to deal with Tedium

I just spent 20 minutes PARSING A DATE. Yes, I realize there are a ton of interesting things about that... but there are also a ton of interesting things elsewhere, and I should never have to deal with this unless my client is Doctor Who or whatever. Even though there are a lot of dates in Ruby, I have never had to deal with parsing dates. OK actually that's not true... I did have to deal with it once. But that was because my users were entering dates like &quot;3/310&quot; ... which was a typo and Ruby's prebuilt tools were like, &quot;Yeah, uh.... year? valid date? give me something I can work with here.&quot;

It isn't fair to say I *never* have to deal with tedium... but honestly I would say it's almost a daily thing with C# and about 90% better in Ruby.

h2. Enumerable Blocks and Tap and Blocks In General

h2. I feel like I'm sacrificing my effectiveness on the alter of infrastructure.

So I recently wrote a Month model because I needed to model that. And then I wanted to get a list of months from month x to month y. For instance, right now I need all months from January of the previous year until December of the current year. But for the sake of completeness, I might want to go backwards... in fact, I anticipate needing that.

In Ruby:
---ruby
  class Month
    ... existing implementation
    def &lt;=&gt;(other_month)
      self.first_day &lt;=&gt; other_month.first_day
    end
  end

  # and then you could get a range by using Ruby's &quot;range&quot; syntax:
  first_month..last_month
---

In C#:
---
  # I'm not sure. I know you would have to implement some kind of interface... perhaps iComperable if memory serves? And then I guess you could do a for loop, but then you wouldn't know for sure whether you needed a &lt; or &gt; operator. 
---


h1. Things I just don't like and/or don't understand about C#

h2. In winforms, it seems like you can't really get away from the codebehind... or whatever that's called... the cs file behind a screen. Everything has to happen in that one file... from validation to parsing of values to ... processing... a nightmare.

h2. Some things I miss about C# when working in Ruby

- Date#ToString has some intuitive formats... on the other hand, Ruby's way is more repeatable.
- interfaces. Yes, that's right. I miss interfaces. Ruby has duck typing... and that works for me. But sometimes I just wish I could ... just ... have interface guarantees.

h2. Some things I'm unsure whether to love or hate

- &quot;using&quot; statements. On one hand, it's great to know exactly what's in there. On the other hand, some limited magic is part of Ruby, both for good and evil. But mostly for good. Depending on the dev.
