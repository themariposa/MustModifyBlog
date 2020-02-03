---
title: "Ask Cucumber with Capybara for inline HTML... now with CSS Selectors!"
layout: 'post'
permalink: 2011/01/18/cucumber-capybara-display-html-inline
published: 2011-01-18 08:07:58 UTC
---
Two very useful cucumber steps:

---
Then 'display the page' do
  puts &quot;\n\n\n#{page.body.to_s}\n\n\n&quot;
end

Then /^display &quot;([^&quot;]*)&quot;$/ do |selector|
  puts &quot;\n\n\n#{find(selector).native.to_html}\n\n\n&quot;
end
---

When you're remoting in to your dev machine, you can't use &quot;Then show me the page&quot; because there is no desktop in which to open the browser... so I created &quot;Then display the page&quot;. It outputs the HTML to the screen for your examination. This becomes very tedious when pages get long... after some help on the capybara mailing list, I created the second entry, which accepts a CSS selector.
