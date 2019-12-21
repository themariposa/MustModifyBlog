module Renderers
  class WelcomeHTMLRenderer < LexiconRenderer 
    def header(text, level)
      level = [level + 3, 5].min
      "<h#{level}>#{text}</h#{level}>"
    end
  end
end
