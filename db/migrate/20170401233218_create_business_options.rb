class CreateBusinessOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :business_options do |t|
      t.string :option
      t.integer :business_id
      t.integer :category_option_id
      t.timestamps
    end
  end
end
