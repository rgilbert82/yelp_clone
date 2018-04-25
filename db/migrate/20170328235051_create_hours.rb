class CreateHours < ActiveRecord::Migration[5.0]
  def change
    create_table :hours do |t|
      t.string :day
      t.time :opens_at
      t.time :closes_at
      t.timestamps
    end
  end
end
