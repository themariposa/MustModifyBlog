class AddPostPublish < ActiveRecord::Migration[6.0]
  def change
  	add_column :posts, :published, :boolean, :after => :id
  end
end
