class CreateBusinessPics < ActiveRecord::Migration[5.0]
  def change
    create_table :business_pics do |t|
      t.string :image
      t.integer :business_id
      t.timestamps
    end
  end
end
