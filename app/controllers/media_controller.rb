require 'open-uri'

class MediaController < ApplicationController

  def index
    @albums = JSON.parse(ENV['ALBUMS'])
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
    render nothing: true
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
    payment_request = Paypal::Payment::Request.new(
      :description   => 'Charles Ellsworth Master Collection', # item description
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
    @albums = JSON.parse(ENV['ALBUMS'])
    @token = params[:token]
    @payer_id = params[:PayerID]
    @details = paypal_request.details(@token)
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

      if payment_response.ack == 'Success'
        Curl.post("http://#{ENV['DIGITAL_OCEAN_IP']}/music/create_download_file", {email: params['email']})
      end
    rescue => e
      logger.error e
      flash[:error] = "Your purchase was not successful. Please try again."
      redirect_to action: :index and return
    end
    flash[:notice] = 'Your purchase was successful! Please check your email.'
    redirect_to action: :index
  end

  def purchase_error
    flash[:error] = "There was an error with your purchase. Please try again."
    redirect_to action: :index
  end

  private

  def paypal_request
    @paypal_request ||= Paypal::Express::Request.new(
                                       :username   => ENV['paypal_username'],
                                       :password   => ENV['paypal_password'],
                                       :signature  => ENV['paypal_signature'])
  end
end
