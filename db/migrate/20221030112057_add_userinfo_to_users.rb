class AddUserinfoToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :user_num, :string
  end
end
