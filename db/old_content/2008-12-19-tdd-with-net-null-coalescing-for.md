---
title: "TDD with .NET - null coalescing for defaults"
layout: 'post'
permalink: 2008/12/19/tdd-with-net-null-coalescing-for
published: 2008-12-19 13:06:00 UTC
---
Yet another post in the  &quot;TDD with .NET&quot;:http://blog.mustmodify.com/search/label/TDD%20with%20.NET  series... 

There are some fun tricks that can make code a little bit more elegant for advanced coders, though newer developers will take some adjusting.

Suppose there is a business rule that when a name isn't valid (as defined by is_valid), we should display 'unknown.'

I've created a Name class, which stores a FirstName, MiddleInitial and LastName. I have a property named FullName that returns a string.

---csharp
namespace EduTest{
    [TestFixture]
    public class NameTests
    {
        [Test]
        public void FullName_is_null_if_incomplete()
        {
            Name mick = Factory.Name;
            mick.FirstName = null;
            Assert.Equals(null, mick.FullName);
        }
    }
}
---

seven tests, one failure
---csharp
 public string FullName{
    get
    {
        if (this.is_valid)
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
        else
        {
            return null;
        }
    }
}
---

seven tests, zero failures

This method is long-ish. I would like to refactor it, but I'll hold off for now. I'm also wondering whether this logic actually belongs in this method... but without any feedback from another developer or a good idea to persue, I'm going to leave it alone until it becomes painful or I think of a better option.
Next test...

---
namespace EduTest{
    [TestFixture]
    public class NameTests
    {
        [Test]
        public void ToString_is_Unknown_when_name_is_incomplete()
        {
            Name prince = new Name();
            prince.FirstName = &quot;Prince&quot;;
            prince.LastName = null;
            Assert.Equals(&quot;Unknown&quot;, prince.ToString());
        }
    }
}
---

eight tests, one failure

Now I'm going to use the cool &quot;null-coalescing operator&quot;:http://weblogs.asp.net/scottgu/archive/2007/09/20/the-new-c-null-coalescing-operator-and-using-it-with-linq.aspx ( ?? ).

---csharp
namespace Edu{
    public class Name
    {
        public override string ToString()
        {
            return FullName ?? &quot;Unknown&quot;;
        }
    }
}
---

The null coalescing operator allows you to specify what value you want used if the first value is null.
&quot;hello&quot; ?? &quot;value&quot; results in &quot;hello&quot;null ?? &quot;default&quot; results in &quot;default&quot;

eight tests, zero failures
