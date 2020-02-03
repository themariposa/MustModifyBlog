---
title: "Evolving thoughts about JSON APIs 2: a reason for collection+json"
layout: 'post'
permalink: 2013/11/25/json-apis-collection-plus-json
published: 2013-11-25 21:45:31 UTC
---
This is a follow-up to http://blog.mustmodify.com/2013/10/18/evolving-thoughts-about-apis

cJ is short for collection+JSON because lazy.

h2. Reasons for cJ

Although I normally develop full-stack applications, I was contracted to implement a new API using a somewhat consistent pattern and was getting some positive feedback about it from the dev who was using it to build a site. (Yes, strange not to be doing full-stack. Not my decision.)

I remembered an inspiring presentation by &quot;Ruby Hero Steve Klabnik&quot;:http://www.steveklabnik.com during RubyConf 2012 (?) . The focus of his talk was that APIs should present basically the same information as browsers... and that API clients should consume APIs in basically the same way as browsers... which is to say that they wouldn't &quot;just know&quot; paths on a system. They would go to the welcome page and be able to discover hyperlinks to ... basically the rest of the system. Just like on the webs. And if a link were to change, that would be OK because the welcome page's link would change. The only commitment would be a list of 'rel' tags... a list of tags that provide context to the page.

Although I can't find the original presentation, he obviously has given this talk many times. I found one on the web. He talked about a few API protocols / mime-types... after looking at them, some seemed awkward, others immature, and others overly-erudite. So I figured I could roll my own. lolz. Long story short, I think what I had was pretty decent, but the front-end dev said that inconsistencies between the 'instance' views ( /items/1.json ), the 'resource' views ( /items.json ) and the 'welcome' page ( /index.json ) were a bit of a pain point. Not a big deal, but something that needed handling. And wouldn't it be nice if it were consistent? But it can't be, because on the welcome page, there is no &quot;object&quot; it's just... welcome. Here's what you can do. And on the resource page, it's just one resource. Collection page, collections.

That reminded me about collection+json. So we're going to give it a shot.

h2. Technical Stack

I started out using jBuilder. Unfortunately, jBuilder doesn't lend itself to building collections. And as the name implies, that happens alot in collection+JSON. So I ended up doing hackish things like:

---
link_collection = [
  {
    :href =&gt; items_path,
     :rel =&gt; 'parent'
  },
  {
    :href =&gt; manufacturers_path,
    :rel =&gt; 'manufacturer_resource'
  }
]

@item.options.each do |option|
    link_collection &lt;&lt; 
    {
      :href =&gt; options_path( option ),
      :rel =&gt; 'option_details'
    }
end

json.array! link_collection do |link|
  json.link do |json|
    json.href link[:href]
    json.rel link[:rel]
  end
end
---

it's not the worst code ever, but it's awkward. I ended up moving the link-building code to a helper just because I didn't want it in the view, but then... it was somewhere else. Anyway, suboptimal.

We switched to the &quot;collection-json gem&quot;:http://rubygems.org/gems/collection-json ( NOTE that this is not the same as the collection_json gem, which is apparently no longer maintained? ) and the same code looks more like this:

---
  api.add_link category_path( item.category.first ), 'category'
  api.add_link manufacturer_path( item.manufacturer ), 'manufacturer'
  @item.options.each do |option|
    api.add_link option_path( option ), 'option_details'
  end
---

It's a lot better. So far I've been modeling each endpoint in  app/endpoints... 

---
class ItemsEndpoint &lt; API
  def to_json(atts = {})
    CollectionJSON.generate_for(context.request.path) do |api|
      api.add_item( whatever )
    end
  end
end
---

and app/endpoints/api.rb:

---
class API &lt; Valuable
  has_value :context
  has_value :collection
  has_value :singleton, :klass =&gt; :boolean

  def current_user
    context.send(:current_user)
  end

  def method_missing(method, *args)
    if context.respond_to?(method)
      context.send(method, *args)
    else
      super
    end
  end
end
---

I use the instance flag to determine whether to show nested resources at collection.items[0].links or collection.links. I'm looking at making some minor changes moving forward, but this has worked well.

from the controller:
---
  # GET /items
  # GET /items.json
  def index
    @items = Item.visible_to( current_user )  # visible_to is an AR scope

    respond_to do |format|
      format.html do
        @items = @items.paginate(:page =&gt; params[:page])
        # though sometimes I do pagination in json, too. Hopefully I'll get around to posting about that.
      end

      format.json { render :json =&gt; ItemsEndpoint.new(:context =&gt; view_context, :collection =&gt; @items).to_json }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.visible_to(current_user).where(:id =&gt; params[:id]).first!

    respond_to do |format|
      format.html {}
      format.json { render :json =&gt; ItemsEndpoint.new(:context =&gt; view_context, :collection =&gt; [@item], :singleton =&gt; true ).to_json }
    end
  end

  ... and much much more.
---


