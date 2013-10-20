class ImagesProductsTable < ActiveRecord::Migration
  def change
    create_table :images_products, :id => false do |t|
      t.integer :image_id
      t.integer :product_id
    end
  end
end
