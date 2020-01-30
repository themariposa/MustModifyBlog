class PagesController < ApplicationController
  def welcome
    render layout: 'wide'
  end

  def portfolio
    @projects = YAML.load(File.read('db/portfolio.yml'))
    render layout: 'wide'
  end
end
