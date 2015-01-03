class AddContributionTextToPromotionText < ActiveRecord::Migration
  def change
    add_column :promotion_texts, :contribution_text, :string
  end
end
