class AddProfileOptionsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :i_love, :text
    add_column :users, :hometown, :text
    add_column :users, :website, :string
    add_column :users, :when_im_not_reviewing, :string
  end
end
