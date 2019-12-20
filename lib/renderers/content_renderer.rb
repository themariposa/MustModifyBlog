module Renderers
  class ContentRenderer < Redcarpet::Render::HTML
    include Renderers::BootstrapTableRenderer
  end
end
