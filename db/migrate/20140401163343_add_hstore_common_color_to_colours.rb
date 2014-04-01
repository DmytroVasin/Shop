class AddHstoreCommonColorToColours < ActiveRecord::Migration
  def change
    add_column :colours, :common_colors, :hstore
  end
end
