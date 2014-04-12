class AddHstoreIndexToColours < ActiveRecord::Migration
  def change
    add_hstore_index :colours, :common_colors
    add_hstore_index :products, :materials
    add_hstore_index :products, :zippers
    add_hstore_index :products, :features
  end
end
