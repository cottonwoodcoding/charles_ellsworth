class AdminController < ApplicationController
  before_action :authenticate_admin!

  def mass_signup
      render(:mass_signup, layout: 'no_header')
  end

  def mailing_list_emails
    @emails = MailingList.all.pluck(:email)
  end
end
