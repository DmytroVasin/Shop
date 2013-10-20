class CreateColorsProductsTable < ActiveRecord::Migration
  def change
    create_table :colors_products, :id => false do |t|
      t.integer :color_id
      t.integer :product_id
    end
  end
end
