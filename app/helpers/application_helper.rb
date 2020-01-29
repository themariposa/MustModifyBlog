module ApplicationHelper

  def page_title(value = nil)
    if( value )
      @page_title = value
    else
      @page_title
    end
  end

  def page_title=(value)
    @page_title = value
  end

  def post_permalink_path(post, atts = {})
    datetime_part = post.created_at.strftime("%Y/%m/%d")
    "#{datetime_part}/#{post.slug}"
  end
end
