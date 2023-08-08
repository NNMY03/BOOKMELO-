class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id
      t.integer :book_id
      t.date :reading_finish
      t.text :comment
      t.text :memo
      t.string :star
      t.string :category
      t.boolean :posted_status

      t.timestamps
    end
  end
end
