class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'

  def index
    ratings          = Rating.select(:point)
    @count           = ratings.count
    hash_with_points = ratings.group_by(&:point)

    #TODO: fix this - session
    session[:vote_flag] = nil

    @hash_with_counts, @hash_with_percentege = vote_rank(hash_with_points, @count)
  end
end
