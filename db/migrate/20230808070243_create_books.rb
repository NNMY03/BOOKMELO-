class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string  :title
      t.string  :author
      t.string  :isbn
      t.string  :publisher
      t.string  :img_small
      t.string  :img_big
      t.string  :rakuten_url
      t.text  :item_caption
      t.string  :book_genre_id
      t.boolean :book_status, null: false, default: "false"

      t.timestamps
    end
  end
end
