class AddMoreSlugs < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :slug, :string
    add_column :events, :slug, :string
    add_column :topics, :slug, :string
  end
end
