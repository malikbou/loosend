class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :toilet, null: false, foreign_key: true
      t.integer :toilet_rating
      t.integer :hygiene_rating
      t.text :comment

      t.timestamps
    end
  end
end
