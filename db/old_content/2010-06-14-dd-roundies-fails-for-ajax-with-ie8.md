---
title: "dd_roundies fails for AJAX with IE8"
layout: 'post'
permalink: 2010/06/14/dd-roundies-fails-for-ajax-with-ie8
published: 2010-06-14 14:13:39 UTC
---
Rounding things in IE8 is one of the biggest farses ever.

After some research, I'm using dd_roundies. I won't explain how it works, because you don't deserve that kind of suffering. It seems to work for rounding objects in IE before the page is set to the &quot;ready&quot; state, but it's failing for me in ajax requests (and in fact any javascript that happens after the page hits the &quot;ready&quot; state.)

I found this bit in the code:
--- js
if (DD_roundies.IE8 &amp;&amp; document.attachEvent &amp;&amp; DD_roundies.querySelector) {
	document.attachEvent('onreadystatechange', function() {
		if (document.readyState == 'complete') {
			var selectors = DD_roundies.selectorsToProcess;
			var length = selectors.length;
			var delayedCall = function(node, radii, index) {
				setTimeout(function() {
					DD_roundies.roundify.call(node, radii);
				}, index*100);
			};
			for (var i=0; i&lt;length; i++) {
				var results = document.querySelectorAll(selectors[i].selector);
				var rLength = results.length;
				for (var r=0; r&lt;rLength; r++) {
					if (results[r].nodeName != 'INPUT') { /* IE8 doesn't like to do this to inputs yet */
						delayedCall(results[r], selectors[i].radii, r);
					}
				}
			}
		}
	});
}
---

I already had the round method (below) to use jquery for rounding when that was an option, and roundies otherwise. I wasn't able to find a way to get IE to toggle the ready state of the document on ajax calls, so I created a method trigger_late_rounding( ). 

I'll be replacing &quot;BrowserDetect&quot;:http://www.quirksmode.org/js/detect.html with DD_roundies.IEwhatever as soon as I get around to it.

---js
function round( selector, radius )
{
  if( radius == null )
  {
    radius = &quot;10px&quot;;
  }

  if( BrowserDetect.browser == 'Explorer' )
  {
    DD_roundies.addRule(selector, radius);
  }
  else
  {
    $(function(){
      $(selector).corner(radius);
    });
  }
}

function trigger_late_rounding()
{
  var selectors = DD_roundies.selectorsToProcess;
  var length = selectors.length;

---

In your ajax .js, just...

---js
round('.popup', '10px');
trigger_late_rendering();
---

ugly but effective.

It would be better to have patched dd_roundies, but it's not on github or ... whatever... if dd_roundies is still being maintained and you know where it lives, shoot me a note.

