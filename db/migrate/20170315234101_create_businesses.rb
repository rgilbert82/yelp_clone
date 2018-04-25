class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.string :zip_code
      t.string :price_range
      t.integer :city_id
      t.timestamps
    end
  end
end
