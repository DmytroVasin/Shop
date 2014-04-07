class AddHstoreIndexToColours < ActiveRecord::Migration
  def change
    add_hstore_index :colours, :common_colors
    add_hstore_index :colours, :materials
    add_hstore_index :colours, :zippers
    add_hstore_index :colours, :features
  end
end
