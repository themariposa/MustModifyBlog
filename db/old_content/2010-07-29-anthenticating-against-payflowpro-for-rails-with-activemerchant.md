---
title: "Anthenticating against PayFlowPro for Rails with ActiveMerchant"
layout: 'post'
permalink: 2010/07/29/anthenticating-against-payflowpro-for-rails-with-activemerchant
published: 2010-07-29 07:21:01 UTC
---
Rails is fortunate to have ActiveMerchant, a gem that provides a standard interface for billing. Unfortunately, there are a wide variety of gateways out there and each has their own &quot;uniqueness.&quot; I experienced PayFlowPro's &quot;uniqueness&quot; today and thought I would share my now-working spike code.

THE PARTNER FIELD

The partner field below is optional. If you leave it blank, the default will be PayPal. The other option, apparently, is VeriSign. I have included it here because magical, undocumented parameters confuse people.

MERCHANT LOGIN

in my case, this was the company name without any spaces. It's the same as the merchant login required to log in to the PayflowPro website.

---ruby

  gateway = ActiveMerchant::Billing::PayflowGateway.new(
    :login             =&gt; 'my_company_name',    # 'Merchant Login from the login page
    :user              =&gt; 'my_username',
    :password          =&gt; 'ComPliCatedP4sSw0rd',
    :partner           =&gt; 'PayPal'
  )

credit_card = ActiveMerchant::Billing::CreditCard.new(
                      :number =&gt; '5105105105105100',
                      :month =&gt; '9',
                      :year =&gt; '2011',
                      :first_name =&gt; 'Longbob',
                      :last_name =&gt; 'Longsen',
                      :verification_value =&gt; '123',
                      :type =&gt; 'master'
                    )

# Make a $1 purchase (100 cents)
response = gateway.purchase(100, credit_card)
puts response.success?
puts response.message
---

MOVING FROM A SPIKE TO REAL CODE

Copy the above code, replace your company name, and get that to say &quot;Accepted&quot;... once that's done, check back for my blog entry on the easiest way to set up ActiveMerchant in a Rails app.

ISSUES I EXPERIENCED

PayFlowPro response 26 - Invalid Vendor Account

I was using my username where my merchant login should have been.

PayflowPro response 1 - User authentication failed

Here I was submitting the company name as my :login but was not including my username under :user



REFERENCES

&quot;com.googlegroups.activemerchant - Payflow Pro Integration&quot;:http://markmail.org/message/sjc3nbw2vttredlj

&quot;Payflow Gateway - User authentication failed&quot;:http://groups.google.com/group/activemerchant/browse_thread/thread/e15c44b27a654c9f
