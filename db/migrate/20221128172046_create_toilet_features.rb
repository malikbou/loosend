class CreateToiletFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :toilet_features do |t|
      t.references :toilet, null: false, foreign_key: true
      t.references :feature, null: false, foreign_key: true

      t.timestamps
    end
  end
end
