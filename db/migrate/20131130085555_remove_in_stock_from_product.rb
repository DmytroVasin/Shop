class RemoveInStockFromProduct < ActiveRecord::Migration
  def self.up
		remove_column :products, :in_stock
  end

  def self.down
    add_column :products, :in_stock, :boolean, default: false
  end
end
