class AdminController < ApplicationController
  before_action :authenticate_admin!

  def mass_signup
      render(:mass_signup, layout: 'no_header')
  end

  def mailing_list_emails
    @emails = MailingList.all.pluck(:email)
  end

  def download_link
    Curl.post("http://#{ENV['DIGITAL_OCEAN_IP']}/music/create_download_file", {email: params[:email]})
    flash[:notice] = 'Email Link Has Been Sent'
    redirect_to controller: :home, action: :index
  end
end
