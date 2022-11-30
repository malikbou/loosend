class RemoveHygieneRatingColumnFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :hygiene_rating, :integer
  end
end
