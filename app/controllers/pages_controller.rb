class PagesController < ApplicationController
  def welcome
    @projects = YAML.load(File.read('db/portfolio.yml')).select{|p| p['featured']}
    render layout: 'wide'
  end

  def portfolio
    @projects = YAML.load(File.read('db/portfolio.yml'))
    render layout: 'wide'
  end
end
