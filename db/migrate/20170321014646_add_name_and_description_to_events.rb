class AddNameAndDescriptionToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :name, :string
    add_column :events, :description, :text
    remove_column :events, :end_time
  end
end
