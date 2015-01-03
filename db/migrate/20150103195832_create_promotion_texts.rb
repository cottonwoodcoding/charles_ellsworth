class CreatePromotionTexts < ActiveRecord::Migration
  def change
    create_table :promotion_texts do |t|
      t.text :header_content
      t.text :footer_content

      t.timestamps
    end
  end
end
