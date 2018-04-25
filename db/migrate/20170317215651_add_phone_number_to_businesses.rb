class AddPhoneNumberToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :phone_number, :string
  end
end
