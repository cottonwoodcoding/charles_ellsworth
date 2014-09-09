class AdminController < ApplicationController

  def mass_signup
    render(:mass_signup, layout: 'no_header')
  end

  def signup
    list = MailingList.new(email: params[:email])
    if list.save
      render text: "You've been successfully added to the mailing list.", status: 200
    else
      render text: "Email: #{list.errors[:email].first}", status: 500
    end
  end
end
