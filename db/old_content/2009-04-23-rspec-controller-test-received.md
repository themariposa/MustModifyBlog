---
title: "received unexpected message :split [ an error in an rspec controller test ]"
layout: 'post'
permalink: 2009/04/23/rspec-controller-test-received
published: 2009-04-23 07:32:00 UTC
---
original code:

--- ruby
it 'should add a flight given the correct data' do
  details = Factory.build(:flight).attributes
  @mock_flight.should_receive(:save).and_return(true)  
  Flight.should_receive(:new).with(details).and_return(@mock_flight)
  post 'create', :flight =&gt; details
  response.should redirect_to( @mock_flight ) 
end
---

correction:
---
-    response.should redirect_to( @mock_flight )
+   response.should redirect_to( flight_url(@mock_flight) )
---

notes:
-  @mock_flight is defined in a before(:all) block.
-  flight_url is generated by the following line in config/routes.rb:
        map.resources :flights
