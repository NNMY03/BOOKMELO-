class CreateHomes < ActiveRecord::Migration[6.1]
  def change
    create_table :homes do |t|
      t.text :attention

      t.timestamps
    end
  end
end
