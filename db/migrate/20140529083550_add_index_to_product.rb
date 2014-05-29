class AddIndexToProduct < ActiveRecord::Migration
  def change
    add_index :categories_products, :category_id
    add_index :categories_products, :product_id
    add_index :genders_products, :gender_id
    add_index :genders_products, :product_id
    add_index :products, :brand_id
    add_index :colors, :colour_id
    add_index :colors, :image_id
    add_index :colors, :product_id
  end
end
