class AddDetailsToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :reservations, :boolean
    add_column :businesses, :waiter_service, :boolean
    add_column :businesses, :delivery, :boolean
    add_column :businesses, :takeout, :boolean
    add_column :businesses, :accepts_credit_cards, :boolean
    add_column :businesses, :alcohol, :boolean
    add_column :businesses, :outdoor_seating, :boolean
    add_column :businesses, :caters, :boolean
    add_column :businesses, :wifi, :boolean
    add_column :businesses, :attire, :string
    add_column :businesses, :ambience, :string
    add_column :businesses, :noise_level, :string
  end
end
