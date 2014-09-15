class AdminController < ApplicationController
  before_filter :admin_signed_in?

  def mass_signup
      render(:mass_signup, layout: 'no_header')
  end

  def mailing_list_emails
    @emails = MailingList.all.pluck(:email)
  end
end
