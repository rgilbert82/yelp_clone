class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :topic_category_id
      t.integer :city_id
      t.integer :user_id
      t.timestamps
    end
  end
end
