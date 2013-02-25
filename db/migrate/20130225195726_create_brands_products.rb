class CreateBrandsProducts < ActiveRecord::Migration
  def change
    create_table :brands_products, :id => false do |t|
      t.integer :brand_id
      t.integer :product_id
    end
  end
end
