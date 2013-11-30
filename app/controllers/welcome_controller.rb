class WelcomeController < ApplicationController
  def index
    # Rating menu ( Vote menu )
    @ratings      = Rating.new

    ratings          = Rating.select(:point)
    @count           = ratings.count
    hash_with_points = ratings.group_by(&:point)

    @hash_with_counts, @hash_with_percentege = vote_rank(hash_with_points, @count)

    # New parfume's - for her and him

    products = Product.scoped

    products_for_them = products.order('created_at ASC')
    for_him           = products_for_them.by_gender('Boys').limit(2)
    for_her           = products_for_them.by_gender('Girls').limit(2)

    @for_them         = for_her + for_him

    # Our best sellers
    @best_sellers = products.order('rank DESC').limit(6)
  end
end
