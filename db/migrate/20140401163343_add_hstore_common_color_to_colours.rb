class AddHstoreCommonColorToColours < ActiveRecord::Migration
  def self.up
    add_column :colours, :common_colors, :hstore
    add_column :colours, :materials, :hstore
    add_column :colours, :zippers, :hstore
    add_column :colours, :features, :hstore
  end
  def self.down
    remove_column :colours, :common_colors
    remove_column :colours, :materials
    remove_column :colours, :zippers
    remove_column :colours, :features
  end
end

# class AddHstoreCommonColorToColours < ActiveRecord::Migration
#   def self.up
#     add_column :colours, :common_colors, :hstore
#     add_column :products, :materials, :hstore
#     add_column :products, :zippers, :hstore
#     add_column :products, :features, :hstore
#   end

#   def self.down
#     remove_column :colours, :common_colors
#     remove_column :products, :materials
#     remove_column :products, :zippers
#     remove_column :products, :features
#   end
# end
