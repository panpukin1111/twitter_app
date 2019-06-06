class AddIndexGroupUserUnique < ActiveRecord::Migration[5.2]
  def change
    add_index :group_users, [:user_id, :group_id], unique: true
  end
end
