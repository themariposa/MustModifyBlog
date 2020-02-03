---
title: "Introduction to Unit Testing in .NET using TDD"
layout: 'post'
permalink: 2008/12/19/introduction-to-unit-testing-in-net
published: 2008-12-19 08:15:00 UTC
---
Test Driven Development - noun, also TDD  - The step-by-step process of creating an application that is well tested by codifying expectations as tests, then implementing the solution to that test. As implied by the name, the tests drive the implementation, instead of meandering randomly through the code, changing things willy-nilly.

TDD changes the mindset of development so that it alternates between the big-picture thinking and detailed thinking in an orderly process.
Here are the steps:

# identify the behavior you expect
# write code that ensures that behavior (the test)
# run the code, seeing it fail 
# write the simplest code you can write that will correctly pass the test
# see it pass
# optionally refactor and test again
# repeat


EXAMPLE
In this example, I'm using csTest, though there are several good free and pay frameworks for .NET.
1. Identify the behavior you expect

I need to be able to store names. I want to be able to enter a first name, middle initial, and last name, then see the full name. 

I don't need to test C#. We assume that if we type 'class Name' that a class named Name will be available. We want to wait until there is some interaction, complexity, etc., to write a test. Here's what I'll write first:

---csharp
using System;using System.Collections.Generic;
using System.Text;

namespace Edu{
    public class Name
    {
        public string FirstName;
        public char MiddleInitial;
        public string LastName;
    }
}
---

2. Write code that ensures that behavior (the test)
---csharp
using System;
using System.Collections.Generic;
using System.Text;
using csUnit;
using Edu;

namespace EduTest{
    [TestFixture]
    public class NameTests
    {
        [Test]
        public void ToStringConcatinatesFirstMiddleAndLast()
        {
            Name john = new Name();
            john.FirstName = &quot;John&quot;;
            john.MiddleInitial = 'E';
            john.LastName = &quot;Doe&quot;;
            Assert.Equals(&quot;John E. Doe&quot;, john.ToString());
        }
    }
}
---

3. Run the test, seeing it fail.

csUnit provides a Visual Studio plugin, which I use to run the test. Though this may be counter-intuitive, I'm happy to see that it fails.
 &quot; !http://4.bp.blogspot.com/_VeJd3vmTCZg/SUvTfe1Nh6I/AAAAAAAAIB0/_CEfMQbju7Q/s320/Fullscreen+capture+12192008+115900+AM.jpg! &quot;:http://4.bp.blogspot.com/_VeJd3vmTCZg/SUvTfe1Nh6I/AAAAAAAAIB0/_CEfMQbju7Q/s1600-h/Fullscreen+capture+12192008+115900+AM.jpg 

one test, one failure

4. write the simplest code you can write that will correctly pass the test

Now that we have a failing test, we need to make it pass. Add this to the Name class:
---csharp
        public override string ToString()
        {
            StringBuilder full_name = new StringBuilder();
            full_name.Append(FirstName);
            full_name.Append(MiddleInitial);
            full_name.Append(LastName);
            return full_name.ToString();
        }
    }
}
---

I run the test. Blah! Expected &quot;John E. Doe&quot; got &quot;JohnEDoe&quot;. Oh, right. Ok. Change the implementation of ToString:

---csharp
         public override string ToString()
        {
            StringBuilder full_name = new StringBuilder();
            full_name.Append(FirstName);
            full_name.Append(' ');
            full_name.Append(MiddleInitial);
            full_name.Append(&quot;. &quot;);
            full_name.Append(LastName);
            return full_name.ToString();
        }
---

5. see it pass 

&quot; !http://1.bp.blogspot.com/_VeJd3vmTCZg/SUvWEZDq0BI/AAAAAAAAIB8/wC2UoA-AecE/s320/Fullscreen+capture+12192008+121143+PM.jpg! &quot;:http://1.bp.blogspot.com/_VeJd3vmTCZg/SUvWEZDq0BI/AAAAAAAAIB8/wC2UoA-AecE/s1600-h/Fullscreen+capture+12192008+121143+PM.jpg one test, zero failures

Success! 

6. Optionally, refactor

We can refactor if we want. I almost always want. :)

It seems like this functionality would be more logically in a property called FullName. This makes the method more like what I've heard called an Executable Comment.

---csharp
         public string FullName
        {
            get
            {
                StringBuilder full_name = new StringBuilder();
                full_name.Append(FirstName);
                full_name.Append(' ');
                full_name.Append(MiddleInitial);
                full_name.Append(&quot;. &quot;);
                full_name.Append(LastName);
                return full_name.ToString();
            }
        }

        public override string ToString()
        {
            return FullName;
        }
---

7. Repeat

Great, so let's move on. Now, of course, I need to address the possibility that there might not be a middle name.

---csharp
         [Test]
        public void FullNameHandlesMiddleInitialIntelligently()
        {
            Name jane = new Name();
            jane.FirstName = &quot;Jane&quot;;
            jane.LastName = &quot;Doe&quot;;

            Assert.Equals(&quot;Jane Doe&quot;, jane.FullName);
        }
---

 &quot; !http://3.bp.blogspot.com/_VeJd3vmTCZg/SUvlMDulNXI/AAAAAAAAICE/Q9fJDtPm5xA/s320/Fullscreen+capture+12192008+11544+PM.jpg! &quot;:http://3.bp.blogspot.com/_VeJd3vmTCZg/SUvlMDulNXI/AAAAAAAAICE/Q9fJDtPm5xA/s1600-h/Fullscreen+capture+12192008+11544+PM.jpg 

two tests, one failure

Now, implement the solution.
---csharp
         public string FullName
        {
            get
            {
                StringBuilder full_name = new StringBuilder();
                full_name.Append(FirstName);
                if (MiddleInitial.HasValue)
                {
                    full_name.Append(' ');
                    full_name.Append(MiddleInitial);
                    full_name.Append('.');
                }
                full_name.Append(' ');
                full_name.Append(LastName);
                return full_name.ToString();
            }
        }
---

two tests, zero failures... perfect!

Just for the sake of example, I'm going to show how unit tests allow you to avoid some kinds of FUD. I want to refactor FullName to pull out the formatting of the middle initial:

---csharp
         public string FormattedMiddleInitial
        {
            get
            {
                StringBuilder initial = new StringBuilder();

                if (MiddleInitial.HasValue)
                {
                    initial.Append(' ');
                    initial.Append(MiddleInitial);
                    initial.Append('.');
                }

                return initial.ToString();
            }
        }

        public string FullName
        {
            get
            {
                StringBuilder full_name = new StringBuilder();
                full_name.Append(FirstName);
                full_name.Append(' ');
                full_name.Append(LastName);

                return full_name.ToString();
            }
        }
---

I skipped a step while extracting that method, but let's say I just overlooked it. I run the tests. Since I only refactored, no functionality should change.

two tests, one failure
expected &quot;John E. Doe&quot; but got &quot;John Doe&quot;

This gives me a really good idea of where to look for a problem. Ah ha! I forgot to add the call to FormattedMiddleInitial. I add in that call, and get the results I expect:

two tests, zero failures

