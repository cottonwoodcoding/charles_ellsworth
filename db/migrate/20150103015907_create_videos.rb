class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :category
      t.integer :priority
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
