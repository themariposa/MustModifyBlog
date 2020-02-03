---
title: "Cucumber via Envjs says \"a.ownerDocument is null\""
layout: 'post'
permalink: 2011/03/10/ownerdocument-null-cucumber-envjs-capybara
published: 2011-03-10 08:02:45 UTC
---
I recently received the following errors when running capybara with envjs. Strangely, there was a kind of double stack trace. Here are the exeptions:

===
 WARNIING:      [Thu Mar 10 2011 09:54:41 GMT-0600 (CST)] {ENVJS} Exception while dispatching events: a.ownerDocument is null
 a.ownerDocument is null (Johnson::Error)
===

===
 WARNIING:      [Thu Mar 10 2011 09:54:41 GMT-0600 (CST)] {ENVJS} Exception while dispatching events: a.ownerDocument is null
oopse a.ownerDocument is null
undefined
inline:129 [JavaScript]
===

===diff

--- a/features/support/env.rb
+++ b/features/support/env.rb
@@ -1,4 +1,4 @@
-ENV[&quot;RAILS_ENV&quot;] ||= &quot;cucumber&quot;
+ENV[&quot;RAILS_ENV&quot;] ||= &quot;test&quot;

 require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

@@ -20,7 +20,6 @@ require 'capybara/session'
 Capybara.default_selector  = :css

 require 'capybara/envjs'
-Capybara.javascript_driver = :envjs

 Before do
   User.test = Factory.create(:user)
===

and for reference:

===
diff config/environments/test.rb config/environments/cucumber.rb

&lt;   config.gem 'factory_girl'
&lt;   config.gem 'rspec', :lib =&gt; false
&lt;   config.gem 'rspec-rails', :lib =&gt; false
&lt;   config.gem 'capybara-envjs', :lib =&gt; 'capybara/envjs'
---
&gt; config.gem 'capybara-envjs', :lib =&gt; 'capybara/envjs'
&gt; config.gem 'factory_girl'
&gt; config.gem 'cucumber',   :lib =&gt; false
&gt; config.gem 'cucumber-rails',   :lib =&gt; false, :version =&gt; '&gt;=0.3.2' unless File.directory?(File.join(Rails.root, 'vendor/plugins/cucumber-rails'))
&gt; config.gem 'database_cleaner', :lib =&gt; false, :version =&gt; '&gt;=0.5.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/database_cleaner'))
===

my complete features/support/env.rb file:
===
ENV[&quot;RAILS_ENV&quot;] ||= &quot;test&quot;

require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

puts &quot;========================================&quot;
puts &quot;RAILS_ENV is #{RAILS_ENV} &quot;
puts &quot;========================================&quot;

require File.expand_path(File.dirname(__FILE__) + '/../../test/helpers/user.rb')

require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'cucumber/rails/world'
require 'cucumber/rails/active_record'
require 'cucumber/web/tableish'

require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/session'

Capybara.default_selector  = :css

require 'capybara/envjs'

Before do
  User.test = Factory.create(:user)
  Given 'I am logged in'

  System.destroy_all
  System.load
end

ActionController::Base.allow_rescue = false
Cucumber::Rails::World.use_transactional_fixtures = true

if defined?(ActiveRecord::Base)
  begin
    require 'database_cleaner'
    DatabaseCleaner.strategy = :truncation
  rescue LoadError =&gt; ignore_if_database_cleaner_not_present
  end
end
===
