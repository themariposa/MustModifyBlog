file_names = Dir.glob('./db/old_content/*.md').sort
file_names.each do |fn|
  puts "====== [   #{ fn } ] ========================"
  content = File.read(fn).split("---\n")
  meta = YAML.load(content[1])

  published = Date.parse(meta['published'])
  slug = (meta['permalink'] && meta['permalink'].split('/').last) || meta['title'].to_slug
  markdown = content[2..-1].join("---\n")
  markdown = markdown.gsub("---", "```").gsub("&quot;", '"').gsub(/\nh1. /, "\n# ").gsub(/\nh1. /, "\n# ").gsub(/\nh3./, '###').gsub(/h2. /, "\n## ").gsub("&lt;", "<").gsub("&gt;", ">").gsub("&amp;", "&"),

  Post.create(
    published: !meta['draft'],
    title: meta['title'],
    markdown_content: markdown,
    category: '',
    slug: slug,
    created_at: published
  )
end
