---
title: "TDD with .NET - implicit conversions"
layout: 'post'
permalink: 2008/12/19/tdd-with-net-implicit-conversions
published: 2008-12-19 13:01:00 UTC
---
Continuing the &quot;TDD in .NET&quot;:http://blog.mustmodify.com/search/label/TDD%20with%20.NET series...

 namespace EduTest{
    [TestFixture]
    public class NameTests
    {
        [Test]
        public void name_can_be_implicitly_converted_to_string()
        {
            Name mick = new Name();
            mick.FirstName = &quot;Mick&quot;;
            mick.LastName = &quot;Jagger&quot;;
            string micks_name = mick;
            Assert.Equals(&quot;Mick Jagger&quot;, micks_name);
         }
    }
}

This won't compile. It complains that &quot;Cannot implicityly convert from type 'Edu. Name' to 'string'. We can go ahead and call this a failure.

namespace Edu{
    public class Name
    {
        public static implicit operator string(Name n)
        {
            return n.ToString();
        }
   }
}

Success. Yeah.
