class CreateToilets < ActiveRecord::Migration[7.0]
  def change
    create_table :toilets do |t|
      t.string :name
      t.text :address
      t.time :opens_at
      t.time :closes_at
      t.decimal :fee
      t.string :toilet_code
      t.integer :rating

      t.timestamps
    end
  end
end
