class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :book,       null: false, foreign_key: true
      t.references :customer,   null: false, foreign_key: true
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
