class AddUnreadToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :unread, :boolean
  end
end
