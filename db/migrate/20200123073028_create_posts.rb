class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
    	# add
    	t.integer :user_id
    	t.integer :genre_id
    	t.string :song
    	t.string :album
    	t.string :artist
    	t.string :post_image_id
    	t.text :body

      t.timestamps
    end
  end
end
