class AddMoreDetailsToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :health_inspection, :string
    add_column :businesses, :dogs_allowed, :boolean
  end
end
