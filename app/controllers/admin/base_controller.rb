class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'

  helper_method :sort_column, :sort_direction

  def index
    ratings          = Rating.select(:point)
    @count           = ratings.count
    hash_with_points = ratings.group_by(&:point)

    #TODO: fix this - session
    session[:vote_flag] = nil

    @hash_with_counts, @hash_with_percentege = vote_rank(hash_with_points, @count)
  end

  private

  def sort_column(model = 'Product')
    model.constantize.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
