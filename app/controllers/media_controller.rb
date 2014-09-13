class MediaController < ApplicationController
  def index
    @albums = JSON.parse(ENV['ALBUMS'])
  end

  def albums
  end
end
