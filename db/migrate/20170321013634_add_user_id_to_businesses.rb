class AddUserIdToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :user_id, :integer
  end
end
