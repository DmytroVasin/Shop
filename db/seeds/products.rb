def products_and_dependencies
  brands_ids   = Brand.pluck(:id)
  genders_ids  = Gender.pluck(:id)
  category_ids = Category.pluck(:id)
  colors_ids   = Colour.pluck(:id)

  Product.populate 100 do |product|
    product.title       = Populator.words(2..3).titleize
    product.description = Populator.sentences(5)
    product.price       = [4.99, 19.95, 100, 140.80, 202.70, 350.50, 600.40, 800.00, 950.50, 1050.80]
    product.old_price   = product.price + 100
    product.created_at  = 1.months.ago..Time.now
    product.rank        = [0, 1, 2, 3, 4, 5, 6]
    product.brand_id    = brands_ids
  end


  Product.all.each do |product|
    product.categories << Category.find(category_ids.sample)
    product.genders << Gender.find(genders_ids.sample)
    product.colors.create( colour_id: colors_ids.sample, image_id: Image.first.id)
  end

  Review.populate 3 do |review|
    review.full_name = Faker::Name.name
    review.address = Faker::Address.city
    review.url_id = Product.pluck(:id)
    review.delivery_time = Populator.sentences(2)
    review.quality = Populator.sentences(2)
    review.suggestions = Populator.sentences(2)
  end
end
