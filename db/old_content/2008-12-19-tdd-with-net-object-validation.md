---
title: "TDD with .NET - object validation"
layout: 'post'
permalink: 2008/12/19/tdd-with-net-object-validation
published: 2008-12-19 11:15:00 UTC
---
Using the code from the &quot;Introduction to TDD&quot;:http://blog.mustmodify.com/2008/12/introduction-to-unit-testing-in-net.html post, I now want the Name object to tell me whether or not it is valid. Let's suppose that the business rule is that names must have a first and last name.

I add this to the Name class:

---csharp
        public bool is_valid
        {
            get
            {
                return true;
            }
        }
---

Why return true? Well, I had to return something, and I know I am going to test for things that make this false, so... meh.

So then I write this test:
---csharp
         [Test]
        public void InvalidWithoutFirstName()
        {
            Name jim = new Name();
            jim.LastName = &quot;SomeName&quot;;
            Assert.False(jim.is_valid);
        }
---

three tests, one failure.Expected false, got true.

---csharp
        public bool is_valid
        {
            get
            {
                return (FirstName != null);
             }
        }
---

three tests, zero failures

But wait! (Someone is upset) ... what if they set it to an empty string? Or just put an exclamation point? (etc., etc.) Well, for this example, I don't care. If there is some reason you think this is likely to happen, certainly that would be valid motivation to write a test or two.

Now things start to go a little quicker than in the last post...
---csharp
         [Test]
        public void InvalidWithoutLastName()
        {
            Name jim = new Name();
            jim.FirstName = &quot;Jim&quot;;
            Assert.False(jim.is_valid);
        }
---

four tests, one failure
---csharp
        public bool is_valid
        {
            get
            {
                return ((FirstName != null)&amp;&amp;(LastName != null));
             }
        }
---

four tests, zero failures
Now, because it's so obvious... 

---csharp
         [Test]
        public void name_is_valid_with_expected_parts()
        {
            Name jim = new Name();
            jim.FirstName = &quot;Jim&quot;;
            jim.LastName = &quot;Wright&quot;
            Assert.True(jim.is_valid);
        }
---

[update ... the format of this method name shows my ruby... I actually think its easier_to_read_this than ItIsToReadThis.]

One problem... this test will pass. I really want to see it fail, so...

---csharp
         public bool is_valid
        {
            get
            {
                return false;
//                return ((FirstName != null)&amp;&amp;(LastName != null));
             } 
       }
---

five tests, one failure

---csharp
        public bool is_valid
        {
            get
            {
                return ((FirstName != null)&amp;&amp;(LastName != null)); 
            }
        }
---

five tests, zero failures

Why was I so concerned about seeing it fail? I have written tests in the past that succeeded, then I went ahead assuming that stuff worked. It turned out that the tests were written incorrectly. I was getting false positives and the code was wrong. Finding that later was a mess. This process may not be foolproof, but it's the simplest thing I can do to solve an irritating problem.

So, now we fall into the rule of three-ish... I had a high school teacher who used to say, &quot;Once is an accident, twice is a coincidence, three times is a pattern.&quot; So, when I start to see things three-ish times in code, I look to refactor.

---csharp
namespace EduTest{
    public class Factory
    {
        public static Name Name
        {
            get
            {
                Name x = new Name();
                x.FirstName = &quot;Jane&quot;;
                x.MiddleInitial = 'Q';
                x.LastName = &quot;Public&quot;;
                return x;
            }
        }
    }
---

I'm creating a Factory class because I know this kind of thing happens all the time in testing. We often want a name that is valid, but don't care about the exact contents. In addition to the rule of three-ish, this has another benefit. If I later say that names must have a title, and that's required, then I have to go back and change everything that tests is_valid, because they all assume that only first and last name are required. Now, I can just add everything I need to the factory method, and nullify fields to make sure they are required.  Here are the changes to the test:

---csharp
         [Test]
        public void InvalidWithoutFirstName()
        {
            Name jim = Factory.Name;
            jim.FirstName = null;
            Assert.False(jim.is_valid);
        }

        [Test]
        public void InvalidWithoutLastName()
        {
            Name jim = Factory.Name;
            jim.LastName = null;
            Assert.False(jim.is_valid);
        }

        [Test]
        public void name_is_valid_with_expected_parts()
        {
            Name jim = Factory.Name;
            Assert.True(jim.is_valid);
        }
---

Note that I don't use the factory for the tests that rely on the data in the model. It is likely to change. I only use the factory when I don't care what the data is, only that everything is properly filled out.

five tests, zero failures

There is a lot we can do to make validations cleaner, but since we only have two properties to validate, this is more than sufficient.
