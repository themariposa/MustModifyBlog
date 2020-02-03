---
title: "sending parameters with brackets [ ] via AngularJS"
layout: 'post'
permalink: 2013/12/06/angle-brackets-in-parameter-keys-fail-with-angularjs
published: 2013-12-06 16:19:54 UTC
---
I want an AngularJS controller to POST to a Rails endpoint with parameters like { 'item[price]': '32.50' } and have Rails see it as &quot;item&quot; =&gt; {&quot;price&quot;: &quot;32.50&quot;}. This works perfectly well in normal HTML... it's not clear why it isn't working in Angular.

h3. Via HTTP

It works in a normal HTML form:

---
&lt;form action=&quot;/items.json&quot; method=&quot;POST&quot;&gt;
  &lt;input name=&quot;item[price]&quot; type=&quot;text&quot; value=&quot;32.50&quot; /&gt;
  &lt;input type=&quot;submit&quot;&gt;Save&lt;/input&gt;
&lt;/form&gt;
---

submitting this form, we see this from Rails:

---
Started POST &quot;/items.json&quot; for 192.168.1.20 at 2013-12-06 09:47:04 -0600
Processing by ItemsController#create as JSON
  Parameters: {&quot;item&quot;=&gt;{&quot;price&quot;=&gt;&quot;32.50&quot;}}
---

h3. via $http.post

---
$http.post('/items.json', {'item[price]': '32.50'});
---

and Rails sees:

---
Started POST &quot;/items.json&quot; for 192.168.1.20 at 2013-12-06 09:50:39 -0600
Processing by ItemsController#create as JSON
  Parameters: {&quot;item[price]&quot;=&gt;&quot;32.50&quot;, &quot;item&quot;=&gt;{&quot;item[price]&quot;=&gt;&quot;32.50&quot;}}
---

h2. So what's different?

Checking Chrome's developer tools, under the network tab &gt; Headers, we get some answers

When using a form, I see a section labeled &quot;Form Data&quot;. After clicking &quot;View Source&quot; I get this:

item%5Bprice%5D=32.50

When using AngularJS, I see a section labeled &quot;Request Payload&quot;. After clicking &quot;View Source&quot;, I get this:

{&quot;item[price]&quot;:&quot;32.50&quot;}

AH HA!

h2. Final Solution

---
$scope.submit_data = function()
{
    var xsrf = $.param({'item[price]': '32.50'});

    $http.post('/items.json',
      xsrf,
      {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'}}
    );
}
---

h2. References

&quot;What is the difference between form data and request payload?&quot;:http://stackoverflow.com/questions/10494574/what-is-the-difference-between-form-data-and-request-payload

&quot;How can I make angular.js post data as form data instead of a request payload?&quot;:http://stackoverflow.com/questions/11442632/how-can-i-make-angular-js-post-data-as-form-data-instead-of-a-request-payload

