class Post < ApplicationRecord
	has_many :comments

	paginates_per 3
end