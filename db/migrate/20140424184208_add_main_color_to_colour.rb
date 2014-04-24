class AddMainColorToColour < ActiveRecord::Migration
  def change
    add_column :colours, :main, :string
  end
end
