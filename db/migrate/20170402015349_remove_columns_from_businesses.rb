class RemoveColumnsFromBusinesses < ActiveRecord::Migration[5.0]
  def change
    remove_column :businesses, :dogs_allowed
    remove_column :businesses, :noise_level
    remove_column :businesses, :ambience
    remove_column :businesses, :attire
    remove_column :businesses, :wifi
    remove_column :businesses, :caters
    remove_column :businesses, :outdoor_seating
    remove_column :businesses, :alcohol
    remove_column :businesses, :accepts_credit_cards
    remove_column :businesses, :takeout
    remove_column :businesses, :delivery
    remove_column :businesses, :waiter_service
    remove_column :businesses, :reservations
    remove_column :businesses, :health_inspection
  end
end
