class PagesController < ApplicationController
  def welcome
    render layout: 'wide'
  end

  def portfolio
    render layout: 'wide'
  end
end
