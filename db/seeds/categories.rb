module Seeds
	def create_categories
		[
			'Handbags',
			'Backpacks',
			'Luggage',
			'Wallets & Accessories',
			'Duffle Bags',
			'Messenger Bags',
			'Laptop Bags',
			'Diaper Bags',
			'Briefcases',
			'Lumbar Packs',
			'Tech Accessories',
			'Hydration Packs',
			'Bags & Packs',
			'Lunch Bags',
			'Makeup'
		].each do |name|
			Category.create(name: name)
		end
	end

	module_function :create_categories
end