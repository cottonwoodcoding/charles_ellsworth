class MediaController < ApplicationController
  def index
    @albums = JSON.parse(ENV['ALBUMS'])
    @photos = []
    Dir.foreach("#{Rails.root}/app/assets/images/photos") do |item|
      next if item == '.' || item == '..' || item == '.DS_Store'
      thumb = "#{item.split(".jpg").first}_thumb.jpg"
      @photos << {picture: item, thumb: thumb}
    end
  end

  def albums
  end
end
