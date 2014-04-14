class AddHstoreIndexToColours < ActiveRecord::Migration
  def self.up
    add_hstore_index :colours, :common_colors
    add_hstore_index :products, :materials
    add_hstore_index :products, :zippers
    add_hstore_index :products, :features
  end

  def self.down
    remove_hstore_index :colours, :common_colors
    remove_hstore_index :products, :materials
    remove_hstore_index :products, :zippers
    remove_hstore_index :products, :features
  end
end
