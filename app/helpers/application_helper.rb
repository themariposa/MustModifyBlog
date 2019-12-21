module ApplicationHelper

  def post_permalink_path(post, atts = {})
    datetime_part = post.created_at.strftime("%Y/%m/%d")
    "#{datetime_part}/#{post.slug}"
  end
end
