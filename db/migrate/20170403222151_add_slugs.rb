class AddSlugs < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :slug, :string
    add_column :sub_categories, :slug, :string
    add_column :categories, :slug, :string
    add_column :businesses, :slug, :string
  end
end
