class CreateBusinessSubCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :business_sub_categories do |t|
      t.integer :business_id
      t.integer :sub_category_id
      t.timestamps
    end
  end
end
