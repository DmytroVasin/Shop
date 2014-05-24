class WelcomeController < ApplicationController
  def index
    # Rating menu ( Vote menu )
    @ratings         = Rating.new

    ratings          = Rating.select(:point)
    @count           = ratings.count
    hash_with_points = ratings.group_by(&:point)

    @hash_with_counts, @hash_with_percentege = vote_rank(hash_with_points, @count)

    products      = Product.scoped
    @best_sellers = products.best_sellers.limit(8)
    @newest       = products.order('rank DESC').limit(15)
  end
end
