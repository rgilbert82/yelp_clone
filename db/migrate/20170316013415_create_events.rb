class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.datetime :start_time, :end_time
      t.string :price
      t.integer :business_id
      t.timestamps
    end
  end
end
