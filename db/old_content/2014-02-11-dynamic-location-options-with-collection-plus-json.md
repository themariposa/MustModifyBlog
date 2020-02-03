---
title: "Search w/ Dynamic Options via collection+json"
layout: 'post'
permalink: 2014/02/11/dynamic-location-options-with-collection-plus-json
published: 2014-02-11 19:08:59 UTC
---
We're searching for people using 'location', 'radius', and 'specialization' fields. Since collection+JSON apparently doesn't provide a mechanism for delivering options like the HTML tag `&amp;lt;option&amp;gt;`, we've forked the Ruby gem for collection+JSON and added that feature: 

[Find our repo with details at GitHub]https://github.com/mustmodify/collection-json.rb

Given I am an anonymous user
When I go to the search page
and I enter my postal code
And I select a specialty
And I submit the form
Then I should be on the results page
And I should see my criteria in an updatable form
And I should see the results


And another important scenario:

Given I am on the result page
Then I should see my search criteria
And I should see a list of the cities where the resulting people are located
And I should be able to filter by those cities.


Because of the second scenario, we need to pass back not just the results, but also the inquiry details, which will include our criteria and city list. Collection+JSON is implicitly limited to one kind of result per response, ie you can't have a collection with both an inquiry item AND a result item, since there is no rel-tag in the item. And even if there were a rel-tag... having two kinds of data mixed up together would be a giant mess.

So our challenge is to present meta-data about the search, available filters, and the results.

Our modified collection+json includes a 'related' collection which could hold the inquiry information. However, we need the expressiveness of the 'template' section for this task. So the 'items' collection links to the inquiry that has been submitted. items[0].links gives you a link to the results.

Our modified collection+JSON schema includes 'options' in the template/query section. This is the perfect mechanism for sending back the list of cities. 

But that still leaves the problem of meta-data.... how many results were there? What page are we on? etc.



---json
{
    &quot;collection&quot;: {
        &quot;href&quot;: &quot;/inquiries/4.json&quot;,
        &quot;items&quot;: [
            {
                &quot;href&quot;: &quot;/inquiries/4.json&quot;,
                &quot;data&quot;: [
                    {
                        &quot;name&quot;: &quot;location&quot;,
                        &quot;value&quot;: &quot;70508&quot;
                    },
                    {
                        &quot;name&quot;: &quot;radius&quot;
                    },
                    {
                        &quot;name&quot;: &quot;specialization_id&quot;,
                        &quot;value&quot;: &quot;12&quot;
                    }
                ],
                &quot;links&quot;: [
                    {
                        &quot;href&quot;: &quot;/inquiries/4/results.json&quot;,
                        &quot;rel&quot;: &quot;specialist_search_results_resource&quot;
                    }
                ]
            }
        ],
        &quot;template&quot;: {
            &quot;data&quot;: [
                {
                    &quot;name&quot;: &quot;inquiry[location]&quot;,
                    &quot;prompt&quot;: &quot;Location&quot;,
                    &quot;value&quot;: &quot;70508&quot;
                },
                {
                    &quot;name&quot;: &quot;inquiry[search_area]&quot;,
                    &quot;prompt&quot;: &quot;Where are you looking?&quot;,
                    &quot;options&quot;: [
                        {
                            &quot;value&quot;: &quot;local&quot;,
                            &quot;prompt&quot;: &quot;Close to Me&quot;
                        },
                        {
                            &quot;value&quot;: &quot;us&quot;,
                            &quot;prompt&quot;: &quot;Anywhere in the US&quot;
                        },
                        {
                            &quot;value&quot;: &quot;global&quot;,
                            &quot;prompt&quot;: &quot;Anywhere in the world.&quot;
                        }
                    ]
                },
                {
                    &quot;name&quot;: &quot;inquiry[specialization_id]&quot;,
                    &quot;prompt&quot;: &quot;Category&quot;,
                    &quot;value&quot;: 12,
                    &quot;options&quot;: [
                        {
                            &quot;value&quot;: 1,
                            &quot;prompt&quot;: &quot;Rails&quot;
                        },
                        {
                            &quot;value&quot;: 2,
                            &quot;prompt&quot;: &quot;Ruby&quot;
                        },
                        {
                            &quot;value&quot;: 3,
                            &quot;prompt&quot;: &quot;AngularJS&quot;
                        },
                        {
                            &quot;value&quot;: 4,
                            &quot;prompt&quot;: &quot;jQuery&quot;
                        }
                    ]
                }
            ]
        }
    }
}
---

In order to do this, we will need to have two kinds of locations... a home location and a cities collection. Our cities are actually [CBSAs]:http://en.wikipedia.org/wiki/Core_Based_Statistical_Area, so I'll call them Areas.

Since no values selected would necessarily mean no results, we'll assume a null value means all values. That way, the initial submit will come back something like this:

---
                {
                    &quot;name&quot;: &quot;inquiry[home]&quot;,
                    &quot;prompt&quot;: &quot;I live in&quot;,
                    &quot;value&quot;: &quot;70508&quot;,
                },
                {
                    &quot;name&quot;: &quot;inquiry[areas]&quot;,
                    &quot;prompt&quot;: &quot;Locations&quot;,
                    &quot;value&quot;: [ 10100, 31080, 31060, 35440 ],
                    &quot;options&quot;: [
                        {
                            &quot;value&quot;: 10100,
                            &quot;prompt&quot;: &quot;Aberdeen, SD&quot;
                        },
                        {
                            &quot;value&quot;: 31080,
                            &quot;prompt&quot;: &quot;Los Angeles&quot;
                        },
                        {
                            &quot;value&quot;: 31060,
                            &quot;prompt&quot;: &quot;Los Alamos, NM&quot;
                        },
                        {
                            &quot;value&quot;: 35440,
                            &quot;prompt&quot;: &quot;Newport, OR&quot;
                        }
                    ]
                }
---

h2. Update

We've added a 'meta' element. See discussion here: https://groups.google.com/forum/#!topic/collectionjson/K2ZibVKpA6Q
