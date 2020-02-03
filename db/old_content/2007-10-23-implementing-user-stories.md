---
title: "Implementing User Stories"
layout: 'post'
permalink: 2007/10/23/implementing-user-stories
published: 2007-10-23 14:15:00 UTC
---
This is a continuation of the &quot;user stories&quot;:http://blog.mustmodify.com/2007/10/user-stories.html post.

User Story Cards

User Story Cards are created during meetings of the stakeholders to create the specifications for a program. Picking a specific Episode, we ask stakeholders to describe the users' experience in that episode. Each user story gets hand-written on its own index card and placed in the middle of a conference table. Although this seems existential, the physical existence of the card apparently helps to keep everyone engaged in the process.

Once there is a critical mass of stories, the cards should be sorted by importance to the client. Again, having actual index cards keeps the users engaged. Sort them from left to right in terms of priority. The most important cards will be coded first.

Acceptance Tests

Once the cards are in order of priority, we start with the first card and ask, &quot;How will you know when this is done?&quot; Acceptance Tests follow. These may include sentences, diagrams, drawings, etc. These get written on back of the notecards and stapled together if they don't all fit on the back. Five or so notecards means the card needs to be broken down.

An example would probably be the best way to explain this.

Story:

* As a retail website customer, I would like to be able to delete items out of my shopping cart so that I can check out with only the items I want.

Acceptance Tests:


* A delete box is displayed next to each item in the shopcart.

* An ‘update cart’ button is at the bottom of the list.

* If the user marks the delete box for one or more items and clicks the ‘update cart’ button, a window pops up giving the user the option to delete or move the item(s) to his wishlist. This popup window also has a cancel button.



_ Other possible acceptance tests:

- employee model
- department model
- An employee must have a first name and a last name
- employees have many departments
- departments have one manager, who is an employee
- There is a queue of unopened cases.
- The next case is determined by creation date.

By looking at a very discrete piece of functionality, the stakeholders can create a relatively complete set of functional requirements with little chance of going on too much of a tangent.

Acceptance Tests may also be referred to as Functional Tests. The name Acceptance Tests was chosen to better reflect the idea that some may be aesthetic, etc.

Test Plans

Acceptance Tests drive Test Plans. Tests plans are probably too fine-grained to be developed during a stakeholder meeting, but should be available for review by all stakeholders. Test plans should include both automated and live-tests.

Continuing the example above:
Story:


*  _As a retail website customer, I would like to be able to delete items out of my shopping cart so that I can check out with only the items I want._ 

Acceptance Tests:

* A delete box is displayed next to each item in the shopcart.
* An ‘update cart’ button is at the bottom of the list.
* If the user marks the delete box for one or more items and clicks the ‘update cart’ button, a window pops up giving the user the option to delete or move the item(s) to his wishlist. This popup window also has a cancel button

Live Tests:
* Click the update cart button without checking any items. Should refresh the page.
* Delete one item. Verify it is gone from the cart and not in the wishlist.
* Move one item to the wishlist. Verify it is there and no longer displayed in the cart.
* Delete all the items. The &quot;keep shopping&quot; button should appear.
* (and so on – you get the idea).

Automated Tests:
* item_can_be_removed_from_well_populated_cart
* balance_is_correct_after_removing_item_from_cart
* item_count_is_correct_after_removing_item_from_cart
* after_removing_only_item_in_cart_cart_is_empty


Automated Tests

Anyone who has seriously embraced test driven development knows it is one of the most effective ways to create a solid application -- that is, code that does what it is supposed to do without seemingly-random &quot;quirks&quot;. I have also found that I develop faster by writing test code than by not doing it, because it's easier to identify the end. Finally, if functionality it does break, the team will know about it before the software go to Beta.

As mentioned above, this hierarchical system takes the guess work out of writing tests. Your automated tests should cover all your acceptance tests. Although the logic of the test might be too technical, the specification should include the test cases from the live tests AND the test cases from the automated tests.

The process: Write a test. Verify that the test fails. Create the code. Verify that it passes. Beautiful. Next.

---csharp
function employee_must_have_a_first_name()
{
Employee e = new Employee();
e.last_name = &quot;Jake&quot;;
e.favorite_color = &quot;Red&quot;;
Assert.false( e.save );
e.first_name = &quot;Jim&quot;;
Assert.true( e.save );
}

function employee_must_have_a_last_name()
{
Employee e = new Employee();
e.first_name = &quot;Jake&quot;;
e.favorite_color = &quot;Green&quot;;
Assert.False( e.save );
e.last_name = &quot;Wright&quot;;
Assert.True( e.save );
}
---
