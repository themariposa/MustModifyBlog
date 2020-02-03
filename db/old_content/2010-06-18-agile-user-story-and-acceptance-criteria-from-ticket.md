---
title: "changing an agile ticket with user story and acceptance criteria from a traditional ticket"
layout: 'post'
permalink: 2010/06/18/agile-user-story-and-acceptance-criteria-from-ticket
published: 2010-06-18 09:47:38 UTC
---
This is a real-life example of a ticket write by a client that I converted into an &quot;agile&quot; user story with acceptance criteria, provided for those who want to find out whether there would be value for them in transitioning and those who want to understand the differences between them.


---
Title: Users can create a category from the Add Item screen

The category drop down will contain a new item called &quot;Add a New Category&quot;. When this option is selected a new text field will appear to give the category a name and possibly to select an icon.
---

first step: user story

---diff
-Title: Users can create a category from the Add Item screen
+Title: As a user I want to create a category on the fly from the Add Item Screen so that I can keep the data I have already entered on the new item screen.
---

add acceptance criteria using [given/]when/then format

---diff
- The category drop down will contain a new item called &quot;Add a New Category&quot;. 
- When this option is selected a new text field will appear to give the category a name and possibly to select an icon.
- When the user saves the item the new category will be created and the new item will appear in that category

+ Scenario: Fields Magically Appear
+ When I am on the new item screen
+ And I select 'Add a New Category' from 'Category'
+ Then I will see &quot;Category Name&quot;
+ And I will see &quot;Category Icon&quot;

+ NOTE: that submitting the form below will cause a request/response, but  won't 
+ create the item because we haven't filled in 'Name', a required field. Being back on
+ the form is convenient, though, because it's easier to write an automated test against
+ a form.

+ Scenario: Adding a Category
+ Given there is not a category named 'Pocket Protectors'
+ When I am on the new item screen
+ And I select 'Add a New Category' from 'Category'
+ And I fill in 'Category Name' with 'Pocket Protectors'
+ And I select &quot;house&quot; from &quot;Category Icon&quot;
+ And I submit the form
+ Then 'Category' should be 'Pocket Protector'

+ Scenario: Can't create duplicate category names
+ Given there is a category named 'Pocket Protectors'
+ When I am on the new item screen
+ And I select 'Add a New Category' from 'Category'
+ And I fill in 'Category Name' with 'Pocket Protectors'
+ And I select &quot;house&quot; from &quot;Category Icon&quot;
+ And I submit the form
+ Then 'Category' should be 'Add a New Category'
+ And 'Category Name' should be 'Pocket Protector
+ and 'Category Icon' should be 'house'

---


