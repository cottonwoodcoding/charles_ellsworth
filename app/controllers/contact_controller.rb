class ContactController < ApplicationController
  def index
  end

  def contact
    begin
      ContactNotifier.send_contact_email(params[:name], params[:email], params[:message])
      render(text: 'Your email was sent successfully!', status: 200) and return
    rescue
      render(text: 'There was an error sending contact us email. Please try again', status: 400) and return
    end
  end
end
