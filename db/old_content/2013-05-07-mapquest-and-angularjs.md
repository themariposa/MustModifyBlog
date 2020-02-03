---
title: "MapQuest and AngularJS"
layout: 'post'
permalink: 2013/05/07/mapquest-and-angularjs
published: 2013-05-07 16:41:48 UTC
---
For my current project, I need to show MapQuest maps next to an address form. As the user enters an address, I need the map to attempt to show the address.

Note: When testing, I often use console.log... so if you don't have developer tools installed, some of these won't work for you.


h3. Step One: Basic Gist

Using &quot;this basic angularjs gist&quot;:https://gist.github.com/ProLoser/3172544 as a starting place, I added the basic code from MapQuest's open data API. It works!

&quot;Source&quot;:https://gist.github.com/mustmodify/5533979/99eddfa86956f960c9db3b6b4b6be418c7df86e9
&quot;Outcome&quot;:http://bl.ocks.org/mustmodify/5533979/99eddfa86956f960c9db3b6b4b6be418c7df86e9

h3. Step Two: using AngularJS templates ( the single-page-app thing )

In this case, you can see that the angular app is active... the word &quot;World&quot; replaces {{name}}. Importantly, though the content here is generated on the server side, not the client side. In my project, the map must be rendered by angularjs on the client side as part of a &quot;single-page-app.&quot; This has something to do with HTML5 and hashtag-urls. I'm still not totally comfortable with these concepts yet,  but I have seen their coolness and am getting there.

Steps to transition this from server-side to client-side rendering:
* Move the content to a template file (map.html) 
* create a router that will recognize the current location and pick the right template to render
* add &amp;lt;div ng-view/&amp;gt; or equivalent on the server side so Angular knows where to place its content.

Here are the changes:
&lt;script src=&quot;https://gist.github.com/mustmodify/5534828.js&quot;&gt;&lt;/script&gt;
&quot;Outcome&quot;:http://bl.ocks.org/mustmodify/5533979/99eddfa86956f960c9db3b6b4b6be418c7df86e9

Not surprisingly, the map disappears. Note this line of javascript:

---javascript
      MQA.EventUtil.observe(window, 'load', function() {
---

so the map is drawn on window load. And angular is still loading so the #map div isn't available at that time. You can tell that the map.html view is being rendered, though, because &quot;Here is the map&quot; acts as a canary.

&lt;iframe src=&quot;http://run.plnkr.co/plunks/WxY7RvAHyFv4zVRjpyoj/&quot; width=&quot;270&quot; height=&quot;200&quot; &gt;&lt;/iframe&gt;

h3. Step Three: get my map back.

based on the referenced Stack Overflow pages, looks like $routeChangeSuccess might be a winner.

&quot;Diff&quot;:https://gist.github.com/mustmodify/5535266

&lt;iframe src=&quot;http://run.plnkr.co/plunks/A85OQpifOiuqPXpEU76W/&quot; width=&quot;270&quot; height=&quot;200&quot; &gt;&lt;/iframe&gt;

However, the $routeChangeSuccess event is called twice. The first time, it is unsuccessful, since there is no #map present. ( this is the redirect in the router. )

&quot;Here's one possible fix.&quot;:https://gist.github.com/mustmodify/5535599 It won't work once we have multiple routes, though.

h3. Step Four: Add Address Form

&lt;iframe src=&quot;http://run.plnkr.co/plunks/nzoQAetrUDfqrXg5cfsd/&quot; width=&quot;80%&quot; height=&quot;400&quot;&gt;
&lt;/iframe&gt;


h3. Step Five: Map Address

Adding ng-model=&quot;location.zipcode&quot; to the input tags for the form, we can then reference that data from angularjs via $scope.location.zipcode. We shouldn't bother mapping until we have at least a complete zipcode:

For diff, see https://gist.github.com/mustmodify/5533979/revisions revisions 676bf92 and 49f3f96

&lt;iframe src=&quot;http://run.plnkr.co/plunks/KvBZTReYoBWG87bywosR/&quot; width=&quot;95%&quot; height=&quot;450&quot;&gt;
Loading...
&lt;/iframe&gt;

h3. Step Six: Cartography

This is actually version 3 of our app. Previous versions integrated with MapQuest with heavy-handed jQuery. Instead of reusing that code I'm investing time in getting a MapQuest situation working... hopefully that pays off. It's a risk, but I think a useful one.

AngularJS has Directives which, in theory, should allow me to abstract away the setup to a plugin. 

code: http://plnkr.co/edit/lEvDK8NrvR2K5Ephsy7e

&lt;iframe src=&quot;http://run.plnkr.co/plunks/lEvDK8NrvR2K5Ephsy7e/&quot; width=&quot;500&quot; height=&quot;500&quot;&gt;Loading&lt;/iframe&gt;

h2. References

&quot;Writing AngularJS Services&quot;:http://stackoverflow.com/questions/13320015/how-to-write-a-debounce-service-in-angularjs

h3. AngularJS docs

&quot;ngResource&quot;:http://docs.angularjs.org/api/ngResource.$resource restful resource part.

&quot;angular.extend&quot;:http://docs.angularjs.org/api/angular.extend may help me add methods to models.

&quot;AngularJS Directives&quot;:http://docs.angularjs.org/guide/directive

&quot;GoogleMaps AngularJS Directive&quot;:https://github.com/nlaplante/angular-google-maps/blob/master/src/angular-google-maps.js

h3. Ways to display webpages that use angularjs and multiple files

&quot;Plnkr.co&quot;:http://plnkr.co -- this is cool because you can (a) reference gists (a la http://plnkr.co/edit/gist:5533979?p=preview )... this is how the people on #angularjs ask you to present your questions so they don't have to guess what you're doing. However, you can't embed code from a gist in your blog... you must create a &quot;plunk&quot; and use that. Also, doesn't seem to be able to reference previous versions by commit number.

&quot;bl.ocks.org&quot;:http://bl.ocks.org allows you to render github gists based on a gist number, OR a gist number and a revision number. Uses github's URL structure.... which I guess isn't as much a feature as it gives me the impression that it's a lightweight, and by implication hopefully well-crafted and stable, layer. Plnkr's embeding doesn't add anything to the page... just shows the content from index.html. bl.ocks.org includes title, your output, and then your code. So a bit less useful for iframes, but great for linking. For instance, try http://bl.ocks.org/mustmodify/5533979/1e4fac2390cadc16c4bf78ba4c83ba582ad1ec6b

h3. On Events

&quot;SO: AngularJS: how to run additional code after rendering a template&quot;:http://stackoverflow.com/questions/12304291/angularjs-how-to-run-additional-code-after-angularjs-has-rendered-a-template

&quot;SO: AngularJS, how to watch for a route change&quot;:http://stackoverflow.com/questions/14765719/angularjs-how-to-watch-for-a-route-change

&quot;SO: AngularJS: Handling route changes&quot;:http://stackoverflow.com/questions/16140415/handling-route-changes-in-angularjs

&quot;Events Not Documented&quot;:https://github.com/angular/angular.js/issues/1569

h3. On Mapping

&quot;MapQuest Open SDK API Docs&quot;:http://developer.mapquest.com/web/documentation/open-sdk/javascript/v7.0/api/MQA.Control.html -- mostly harmless
