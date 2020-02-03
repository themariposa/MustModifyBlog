---
title: "validates_uniqueness_of results in \" undefined method `text?' for nil:NilClass \""
layout: 'post'
permalink: 2010/07/07/validates-uniqueness-undefined-method-text-for-nil
published: 2010-07-07 14:56:11 UTC
---
I had the following model:

--- ruby
class Visit &lt; ActiveRecord::Base

  belongs_to :visit_type
  belongs_to :patient

  validates_presence_of :visit_type
  validates_presence_of :patient
  validates_presence_of :date

  validates_uniqueness_of :visit_type

end
---

I changed :visit_type to :visit_type_id and it went away.
