class ShowsController < ApplicationController
  def index
    @shows = Show.find(:all, order: 'date')
  end
end
