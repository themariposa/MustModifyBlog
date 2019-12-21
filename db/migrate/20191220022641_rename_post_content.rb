class RenamePostContent < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :content, :markdown_content
  end
end
