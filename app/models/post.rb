class Post < ApplicationRecord
	has_many :comments, dependent: :destroy

	has_rich_text :text

	paginates_per 8

	validates_presence_of :title
  validates_presence_of :title

  scope :published, -> { where(published: true)}

  def self.find_by_permalink(year, month, day, slug)
    Post.where('DAY(created_at) = :day AND MONTH(created_at) = :month AND YEAR(created_at) = :year', {year: year, month: month, day: day}).where(slug: slug, published: true)
  end

  def title=(value)
    write_attribute(:title, value)
    if slug.blank?
      self.slug = value.to_s.to_slug
    end
  end
end
