class ContactNotifier < ActionMailer::Base
  default from: "contact@charlesellsworth.com"

  def send_contact_email(name, email, message)
    mail(to: 'jakesorce@gmail.com',
    subject: "#{email} - has a question about charlesellsworth.com",
    body: "#{name.pluralize} message: #{message}").deliver
  end
end
