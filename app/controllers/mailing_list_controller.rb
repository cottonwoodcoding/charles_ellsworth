class MailingListController < ApplicationController
  def signup
    list = MailingList.new(email: params[:email])
    if list.save
      render text: "You've been successfully added to the mailing list.", status: 200
      session['mailing_list'] = true
    else
      render text: "Email: #{list.errors[:email].first}", status: 500
    end
  end

  def signed_up
    if session.has_key?('mailing_list')
      render text: 'signed up', status: 200
    else
      render text: 'not signed up', status: 200
    end
  end
end
