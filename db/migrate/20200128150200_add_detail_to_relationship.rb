class AddDetailToRelationship < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :follower_id, :integer
    add_column :relationships, :following_id, :integer

  	add_index :relationships, :follower_id
  	add_index :relationships, :following_id
  	add_index :relationships, [:follower_id, :following_id], unique: true
  end
end
