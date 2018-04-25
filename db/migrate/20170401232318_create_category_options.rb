class CreateCategoryOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :category_options do |t|
      t.string :name
      t.string :options
      t.boolean :searchable
      t.integer :category_id
      t.timestamps
    end
  end
end
