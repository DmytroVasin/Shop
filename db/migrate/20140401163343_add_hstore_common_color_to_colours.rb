class AddHstoreCommonColorToColours < ActiveRecord::Migration
  def self.up
    add_column :colours, :common_colors, :hstore
    add_column :products, :materials, :hstore
    add_column :products, :zippers, :hstore
    add_column :products, :features, :hstore
  end

  def self.down
    remove_column :colours, :common_colors
    remove_column :products, :materials
    remove_column :products, :zippers
    remove_column :products, :features
  end
end
