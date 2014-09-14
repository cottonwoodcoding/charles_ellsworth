class AddPurchaseOptionsToShows < ActiveRecord::Migration
  def change
    add_column :shows, :purchase_options, :string
  end
end
