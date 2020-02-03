---
title: "Patterns with Valuable - the ModelSearch"
layout: 'post'
permalink: 2012/08/24/ruby-valuable-search-pattern
published: 2012-08-24 14:47:49 UTC
---
I find that I write a lot of &quot;advanced search&quot; stuff, and that modeling an advanced search, and having that be in a separate class, is very good for my sanity.

h2. DataSearch model

The schema is below if you're interested. These models usually start in lib, and then move to app/search once I have four or five.

```
describe DataSearch do
  it 'finds data' do
    datum = Factory.create(:datum)
    DataSearch.new.results.should include(datum)
  end
end
```

So this is a &quot;sanity check&quot; test. I typically test what isn't included. But that could mean that I could get half-way through, write some poorly-thought-out condition that excludes everything, and then have to spend 30 minutes tracking it down. Instead, I just start by asserting that everything is included by default. In some cases, you want nothing to result if there are no conditions -- no problem, just write a test that does return some result.

```
class DataSearch &lt; Valuable
  has_collection :codes

  def results
    Datum.find(:all)
  end
```



h3. I want only certain fields

---
describe DataSearch do
  it 'filters by code' do
    datum = FactoryGirl.create(:datum, :code =&gt; 'hr')
    DataSearch.new(:codes =&gt; ['midi-chlorians']).results.should_not include(datum)
  end
end
---

and then

---
class DataSearch &lt; Valuable

  has_collection :codes

  def condition_params
    {
      :codes =&gt; codes
    }
  end

  def conditions
    out = []
    out &lt;&lt; 'code IN (:codes)' if codes.not.empty?
    out.join(' AND ')
  end

  def results
    Datum.find(:all, :conditions =&gt; [conditions, condition_params])
  end

end
---

h3. Filter by visit

---
describe DataSearch do
  it 'filters by visit' do
    one = FactoryGirl.create(:order)
    two = FactoryGirl.create(:order)

    doppleganger = FactoryGirl.create(:datum, :order =&gt; one)
    DataSearch.new(:visit_id =&gt; two.visit_id).results.should_not include(doppleganger)
  end
end
---

and then

---
class DataSearch &lt; Valuable

  has_collection :codes
  has_value :visit_id, :klass =&gt; :integer

  def condition_params
    {
      :codes =&gt; codes,
      :visit_id =&gt; visit_id
    }
  end

  def conditions
    out = []
    out &lt;&lt; 'code IN (:codes)' if codes.not.empty?
    out &lt;&lt; 'orders.visit_id = :visit_id' if visit_id
    out.join(' AND ')
  end

  def joins
    out = []
    out &lt;&lt; 'LEFT OUTER JOIN orders ON data.order_id = orders.id' if visit_id
    out.join(' ') unless out.empty?
  end

  def results
    Datum.find(:all, :conditions =&gt; [conditions, condition_params], :joins =&gt; joins, :group =&gt; 'data.id')
  end

end
---



h2. The Schema

h3. Timepoint

A patient at a point in time.
* patient_id
* date
* physician

h3. Order

a Physician orders some bloodwork or some other test.
* timepoint_id
* panel_name

h3. Datum

* order_id
* code
* value
* units

Datum.validates_uniqueness_of :code, :scope =&gt; :order_id

