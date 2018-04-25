class AddIconToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :icon_class, :string
  end
end
