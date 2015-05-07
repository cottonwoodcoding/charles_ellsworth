class AddDonorsToRaised < ActiveRecord::Migration
  def change
    add_column :raiseds, :donors, :integer
  end
end
