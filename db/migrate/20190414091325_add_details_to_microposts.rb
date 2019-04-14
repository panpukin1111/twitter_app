class AddDetailsToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :status, :integer, null: false, default: 0, index: true
  end
end
