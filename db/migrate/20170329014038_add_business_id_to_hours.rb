class AddBusinessIdToHours < ActiveRecord::Migration[5.0]
  def change
    add_column :hours, :business_id, :integer
  end
end
