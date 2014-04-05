class AddHstoreCommonColorToColours < ActiveRecord::Migration
  def change
    add_column :colours, :common_colors, :hstore
    add_column :colours, :materials, :hstore
    add_column :colours, :zippers, :hstore
  end
end
