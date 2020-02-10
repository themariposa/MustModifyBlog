class ProjectsController < ApplicationController
  def index
    @projects = YAML.load(File.read('db/portfolio.yml'))
  end

  def show
    @project = YAML.load(File.read('db/portfolio.yml')).detect{|p| p['codename'] == params[:id]}

    if @project.nil?
      render text: 'no such project'
    end

  end
end
