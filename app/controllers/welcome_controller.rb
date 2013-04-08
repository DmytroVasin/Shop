class WelcomeController < ApplicationController
  def index
    # BRANDS for menu
    brands           = Brand.joins(:products)
    @brands_left     = brands.random_by_id_shuffle(10)
    @brands_right    = brands.random_by_id_shuffle(10)

    # Rating menu ( Vote menu )
    @ratings         = Rating.new

    ratings          = Rating.select(:point)
    @count           = ratings.count
    hash_with_points = ratings.group_by(&:point)

    @hash_with_counts     = { '1' => 0, '2' => 0, '3' => 0, '4' => 0, '5' => 0, '6' => 0, '7' => 0 }
    @hash_with_percentege = @hash_with_counts

    hash_with_points.each do |key, value|
      @hash_with_counts["#{key}"]     = value.count
      @hash_with_percentege["#{key}"] = (value.count * 100)/@count.to_f
    end

    # New parfume's - for her and him
    products = Product.order('created_at ASC')
    for_him = products.by_category_name('For Him').limit(2)
    for_her = products.by_category_name('For Her').limit(2)

    @for_them = for_her + for_him
  end
end
