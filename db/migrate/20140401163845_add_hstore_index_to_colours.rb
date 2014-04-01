class AddHstoreIndexToColours < ActiveRecord::Migration
  def change
    add_hstore_index :colours, :common_colors
  end
end
