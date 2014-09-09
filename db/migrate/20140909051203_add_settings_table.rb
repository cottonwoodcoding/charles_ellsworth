class AddSettingsTable < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key, unique: true
      t.text :value
    end
  end
end
