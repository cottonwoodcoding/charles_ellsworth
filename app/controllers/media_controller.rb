require 'open-uri'
require "#{Rails.root}/lib/services/image_shack"

class MediaController < ApplicationController
  include ImageShack

  def index
    @albums = JSON.parse(ENV['ALBUMS'])
    @photo_data = {}
    image_shack_images.each do |image|
      image_hash = {}
      direct_link = image['direct_link']
      image_hash[:src] = direct_link
      image_hash[:description] = image['description']
      image_hash[:thumb] = thumbnail(direct_link)
      album = image['album']
      if @photo_data.has_key?(album['id'])
        @photo_data[album['id']][:images] << image_hash
      else
        @photo_data[album['id']] = { name: album['title'], images: [] }
        @photo_data[album['id']][:images] << image_hash
      end
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
