class CreatePerfumes < ActiveRecord::Migration
  def change
    create_table :perfumes do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.boolean :in_stock

      t.timestamps
    end
  end
end
