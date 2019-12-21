class AddSlugs < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :slug, :string, :after => :category
    add_index :posts, [:slug, :created_at]
  end
end
