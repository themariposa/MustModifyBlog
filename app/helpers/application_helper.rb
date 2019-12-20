module ApplicationHelper

  def post_permalink_path(post, atts = {})
    "/#{post.created_at.year}/#{post.created_at.month}/#{post.created_at.day}/#{post.slug}"
  end
end
