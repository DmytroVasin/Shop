class WelcomeController < ApplicationController
  def index
    session[:products_params] = nil
    # Rating menu ( Vote menu )
    @ratings      = Rating.new

    ratings          = Rating.select(:point)
    @count           = ratings.count
    hash_with_points = ratings.group_by(&:point)

    @hash_with_counts, @hash_with_percentege = vote_rank(hash_with_points, @count)


    products = Product.scoped
    @newest = products.where(bestseller: true)
    @best_sellers = products.order('rank DESC').limit(6)
  end
end
