class Post < ApplicationRecord
	has_many :comments

	has_rich_text :text

	paginates_per 3
end