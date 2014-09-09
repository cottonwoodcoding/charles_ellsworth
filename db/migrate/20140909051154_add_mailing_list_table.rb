class AddMailingListTable < ActiveRecord::Migration
  def change
    create_table :mailing_lists do |t|
      t.string :email, unique: true
    end
  end
end
