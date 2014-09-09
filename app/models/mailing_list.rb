class MailingList < ActiveRecord::Base
  attr_accessible :email
  validates_uniqueness_of :email
end
