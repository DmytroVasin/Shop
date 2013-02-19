class CreateCategoriesPerfumes < ActiveRecord::Migration
  def change
    create_table :categories_perfumes, :id => false do |t|
      t.integer :category_id
      t.integer :perfume_id
    end
  end
end
