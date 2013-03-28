def products_and_dependencies
  Product.populate 100 do |product|
    product.title       = Populator.words(2..3).titleize
    product.description = Populator.sentences(5)
    product.price       = [4.99, 19.95, 100, 140.80, 202.70, 350.50, 600.40, 800.00, 950.50, 1050.80]
    product.created_at  = 1.months.ago..Time.now
    product.rank        = [0, 1, 2, 3, 4, 5, 6]
    product.in_stock    = [true, false]
    product.brand_id    = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  end

  category_ids = Category.pluck('id')

  Product.all.each do |product|
    product.categories << Category.find(category_ids.sample)
  end
end