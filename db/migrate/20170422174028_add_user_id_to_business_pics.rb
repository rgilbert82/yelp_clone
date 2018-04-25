class AddUserIdToBusinessPics < ActiveRecord::Migration[5.0]
  def change
    add_column :business_pics, :user_id, :integer
  end
end
