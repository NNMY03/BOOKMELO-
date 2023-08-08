class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn
      t.string :publisher
      t.string :img_small
      t.string :img_big
      t.string :rakuten_url

      t.timestamps
    end
  end
end
