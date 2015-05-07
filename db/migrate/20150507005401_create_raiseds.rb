class CreateRaiseds < ActiveRecord::Migration
  def change
    create_table :raiseds do |t|
      t.float :raised_value
      t.float :goal

      t.timestamps
    end
  end
end
