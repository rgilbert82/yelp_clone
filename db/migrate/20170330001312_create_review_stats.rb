class CreateReviewStats < ActiveRecord::Migration[5.0]
  def change
    create_table :review_stats do |t|
      t.boolean :useful
      t.boolean :funny
      t.boolean :cool
      t.integer :user_id
      t.integer :review_id
      t.timestamps
    end
  end
end
