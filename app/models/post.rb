class Post < ApplicationRecord
	has_many :comments, dependent: :destroy

	has_rich_text :text

	paginates_per 8

	validates_presence_of :title
  validates_presence_of :title

  scope :published, -> { where(published: true)}

  def title=(value)
    write_attribute(:title, value)
    if slug.blank?
      self.slug = value.to_s.to_slug
    end
  end
end
