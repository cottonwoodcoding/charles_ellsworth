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
    client = Picasa::Client.new(user_id: ENV['PICASA_USERNAME'],
                                password: ENV['PICASA_PASSWORD'])
    @photo_data = {}
    client.album.list.albums.each do |a|
      album = client.album.show(a.id)
      name = album.name
      photos = album.photos
      @photo_data[a.id] = {name: name, photos: photos}
    end
    respond_to do |format|
      format.json { render json: @photo_data.to_json }
    end
  end

  def update_photos
    client = Picasa::Client.new(user_id: ENV['PICASA_USERNAME'],
                                password: ENV['PICASA_PASSWORD'])
    photos_response = client.album.show(params['id']).photos
    photos = photos_response.map { |p| p.content.src }
    respond_to do |format|
      format.json { render json: { photos: photos }.to_json }
    end
  end
end
