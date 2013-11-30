class RemoveInStockFromProduct < ActiveRecord::Migration
	def change
		remove_column :products, :in_stock
	end
end
