require 'open-uri'

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

  def purchase
    purchasing = params['tracks'].delete_if { |_, value| value == 'off' }
    session['purchasing'] = purchasing

    payment_request = Paypal::Payment::Request.new(
      :description   => 'Charles Ellsworth Promotion Collection', # item description
      :quantity      => 1, # item quantity
      :amount        => params[:total]
    )

    response = paypal_request.setup(
      payment_request,
      ENV['paypal_success_redirect'], # success redirect url
      ENV['paypal_error_redirect'], # error redirect url
    )
    render text: response.redirect_uri
  end

  def purchase_confirm
    @token = params[:token]
    @payer_id = params[:PayerID]
    @details = paypal_request.details(@token)
    @track_info = Hash.new{ |key, value| key[value] = [] }
    session['purchasing'].each do |track_info, _|
      info = track_info.split('~')
      @track_info[info.first] << info.last
    end
  end

  def submit_purchase
    token = params[:paypal_token]
    begin
      details = paypal_request.details(token)
      payment_request = Paypal::Payment::Request.new(
        :description   => details.description,    # item description
        :quantity      => 1,      # item quantity
        :amount        => details.amount.total)
      payment_response = paypal_request.checkout!(token, params[:paypal_payer_id], payment_request)

      session["purchasing"].merge!({email: params['email']})
      if payment_response.ack == 'Success'
        Curl.post("http://#{ENV['DIGITAL_OCEAN_IP']}:3001/music/create_download_file", session['purchasing'])
      end
    rescue => e
      logger.error e
    end
    render nothing: true
  end

  def purchase_error
    binding.pry
  end

  private

  def paypal_request
    @paypal_request ||= Paypal::Express::Request.new(
                                       :username   => ENV['paypal_username'],
                                       :password   => ENV['paypal_password'],
                                       :signature  => ENV['paypal_signature'])
  end
end
