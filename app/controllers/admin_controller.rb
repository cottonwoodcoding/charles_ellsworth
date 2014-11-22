class AdminController < ApplicationController
  before_action :authenticate_admin!

  def mass_signup
      render(:mass_signup, layout: 'no_header')
  end

  def mailing_list_emails
    @emails = MailingList.all.pluck(:email)
  end

  def download_link
    albums = JSON.parse(ENV['ALBUMS'])
    track_info_hash = {}
    albums['ALBUMS'].each do |album|
      album['TRACKS'].each do |track|
        track_info_hash["#{album['NAME']}~#{track['FILENAME']}"] = 'on'
      end
    end
    track_info_hash.merge!(email: params[:email])
    Curl.post("http://#{ENV['DIGITAL_OCEAN_IP']}:3001/music/create_download_file", track_info_hash)
    flash[:notice] = 'Email Link Has Been Sent'
    redirect_to controller: :home, action: :index
  end
end
