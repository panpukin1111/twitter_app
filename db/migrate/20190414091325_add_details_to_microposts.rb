class AddDetailsToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :status, :integer, null: false, default: 1, index: true
  end
end
