class CreateGendersProducts < ActiveRecord::Migration
  def change
    create_table :genders_products, :id => false do |t|
      t.integer :gender_id
      t.integer :product_id
    end
  end
end
