class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books, id: false do |t|
      t.string :title
      t.string :author
      t.string :isbn, null: false, primary_key: true
      t.string :publisher
      t.string :img_small
      t.string :img_big
      t.string :rakuten_url
      t.string :item_caption
      t.string :book_genre_id

      t.timestamps
    end
  end
end
