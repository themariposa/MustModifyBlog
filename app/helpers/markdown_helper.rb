module MarkdownHelper
  def parser
    @parser ||= Redcarpet::Markdown.new(Renderers::ContentRenderer, :tables => true)
  end

  def markdown2html( text )
    parser.render(text.to_s).html_safe
  end
end
