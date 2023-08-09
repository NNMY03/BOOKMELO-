class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books, id: false do |t|
      t.string :title
      t.string :author
      t.bigint :isbn, null: false, primary_key: true
      t.string :publisher
      t.string :img_small
      t.string :img_big
      t.string :rakuten_url

      t.timestamps
    end
  end
end
