---
title: "rspec says: undefined method 'should_receive' for SomeClass"
layout: 'post'
permalink: 2010/04/13/rspec-says-undefined-method-should-receive-for-someclass
published: 2010-04-13 07:14:07 UTC
---
This took up an hour of my life today.

Here's the fix. At some point I'll go back and research &quot;Double Ruby&quot;:http://github.com/btakita/rr to figure out what went wrong, but for now, tests are failing validly... 

---diff
--- a/spec/spec_helper.rb
+++ b/spec/spec_helper.rb
@@ -20,7 +20,7 @@ Spec::Runner.configure do |config|
   config.use_instantiated_fixtures  = false
   config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

-  config.mock_with :rr
+#  config.mock_with :rr

   def set_current_user(user)
     stub(controller).current_user { user }
---
