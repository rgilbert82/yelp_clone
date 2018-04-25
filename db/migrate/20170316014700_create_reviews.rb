class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :star_rating
      t.integer :user_id
      t.integer :business_id
      t.timestamps
    end
  end
end
