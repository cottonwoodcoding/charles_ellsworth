class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.datetime :date
      t.string :venue
      t.string :location
      t.string :tickets

      t.timestamps
    end
  end
end
