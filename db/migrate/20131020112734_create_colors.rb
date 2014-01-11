class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.integer :colour_id
      t.integer :image_id
      t.integer :product_id

      t.timestamps
    end
  end
end
