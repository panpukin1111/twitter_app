class CreateNeighborhoodMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :neighborhood_members do |t|
      t.integer :neighborhood_id
      t.integer :user_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
