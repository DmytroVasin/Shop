class AddLinkToProduct < ActiveRecord::Migration
	def change
  	add_column :products, :link_href, :text
   end
end
