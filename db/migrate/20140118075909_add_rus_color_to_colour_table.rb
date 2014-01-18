class AddRusColorToColourTable < ActiveRecord::Migration
  def change
  	add_column :colours, :name_rus, :string
  end
end
