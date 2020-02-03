---
title: "Polymorphic Associations in Rails using xid ( ids unique across the system )"
layout: 'post'
permalink: 2009/07/01/polymorphic-associations-in-rails-using
published: 2009-07-01 08:41:00 UTC
---
On a recent project, the tech-savvy client told me we would be using xids. These are different from regular IDs in that they are a unique identifier across the domain. So, if you create a user with the ID 1000, then you create a ticket, it would have the id 1001, and then when you created some other object, it would have the id 1002.

His logic was that it would allow you to go to one central place to find any resource, if you only had the ID. Although we haven't found a use for that on the public surface of the site, it has been very useful from the polymorphic association side.

Here's what the Rails documentation shows for a polymorphic association:

---ruby
class Asset
  belongs_to :attachable, :polymorphic =&gt; true 
end

class Post
  has_many :assets, :as =&gt; :attachable  
    # The :as option specifies the polymorphic interface to use. end
  @asset.attachable = @post
end
---

Say you have a Bus, and it can either be owned by a coop, an individual, or a company.
---ruby
class Bus
  include link_to_map
  belongs_to_mapped :owner ... 
end
---

The busses table has an owner_xid field. Since the xid field is unique, there is no need to store the type of owner. This makes me happy because it seems to extend Ruby's loose typing to the data level. You can stuff any kind of object there without extra work.

Here's how we're doing it...

belongs_to_mapped (see lib/mappable_associations.rb, below) dynamically defines the getters and setters. In this case, owner, owner=, owner_xid, owner_xid=.

Bus#owner would look something like:
---ruby
def owner 
   @owner ||= Map.lookup( owner_xid ) 
end
---

* @owner keeps the object cached so you don't have to load it from the database every time you access it. 
* Map is the class that hands out the XIDs. It keeps a record of the klass associated with each XID. 
* Map.lookup takes any xid and returns the record it represents, raising an exception if it isn't found.

All the code is below.

As I said before, I like the idea of belongs_to_mapped. With that said, it is the only benefit we're getting from the XID system, which was implemented to solve a problem we weren't having. While it isn't high-maintenance, it's more than no-maintenance. So, unless you already have such a system in place, this probably wouldn't be a good enough reason to implement one.

the Map table: 
--- ruby
class Map

   #fields xid, item_type

   set_primary_key &quot;xid&quot;

   def klass 
      item_type.classify.constantize 
   end

   def entry 
      klass.find xid 
   end 

   class &lt; self
      def lookup(xid)
         map = find xid # raises if not found 
         map.entry
      end
   end 
end
---

lib/mappable_associations.rb 
---ruby
module MappableAssociations
   def belongs_to_mapped(name)
      cache = &quot;@#{name}&quot; 
      foreign_key = &quot;#{name}_xid&quot; 
 
      define_method name do 
         instance_variable_get(cache) || ( key = read_attribute(foreign_key) 
         model = Map.lookup( key ) if key instance_variable_set(cache, model) ) 
      end

      define_method(&quot;#{name}=&quot;) do |value| 
         instance_variable_set(cache, value) 
         new_xid = value ? value.xid : nil 
         write_attribute(foreign_key, new_xid) 
      end

      define_method(&quot;#{foreign_key}=&quot;) do |value| 
         id = value.blank? ? nil : value.to_i 
         instance_variable_set(cache, Map.lookup(id)) 
         if id write_attribute(foreign_key, id) 
      end

      define_method(foreign_key) do 
         read_attribute(foreign_key) 
      end 

      define_method(&quot;save_#{name}&quot;) do 
         instance = instance_variable_get(cache) 
         instance.save if instance 
      end

      before_save &quot;save_#{name}&quot;
   end
end
---

lib/link_to_map.rb
---ruby
module LinkToMap
   def self.included(base) 
      base.set_primary_key &quot;xid&quot; 
      base.has_one :map, :dependent =&gt; :destroy, :foreign_key =&gt; 'xid' 
      base.before_create :link_to_map 
      base.extend MappableAssociations 

      define_link_to_map 
   end 

   def self.define_link_to_map 
      class_eval(&lt;&lt;-EOS, __FILE__, __LINE__) EOS 
   end 
end
---
