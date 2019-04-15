class PagesController < ApplicationController
  def home
    render layout: 'no_container'
  end

  def about; end
end
