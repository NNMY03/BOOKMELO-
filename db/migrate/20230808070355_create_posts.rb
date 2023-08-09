class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id,   null: false
      t.integer :book_id
      t.date :reading_finish,   null: false
      t.text :comment
      t.text :memo
      t.string :star
      t.string :category,       null: false
      t.boolean :posted_status, null: false, default: "false"

      t.timestamps
    end
  end
end
