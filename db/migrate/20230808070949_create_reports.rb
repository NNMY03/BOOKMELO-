class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :customer_id, null: false
      t.integer :book_id,     null: false
      t.text :reason,         null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
