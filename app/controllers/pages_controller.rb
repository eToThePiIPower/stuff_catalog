class PagesController < ApplicationController
  def home
    render layout: 'jumbotron'
  end

  def about; end
end
