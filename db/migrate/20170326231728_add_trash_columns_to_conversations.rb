class AddTrashColumnsToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :sender_trash, :boolean
    add_column :conversations, :recipient_trash, :boolean
  end
end
