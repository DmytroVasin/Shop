class RatingsController < ApplicationController
  def create
    point = params[:rating][:point].to_i
    if ( 1 <= point ) && ( point <= 7)
      @rating = Rating.new
      @rating.point = point
      @rating.save
      flash[:notice] = 'Rating saved'
      redirect_to root_path
    else
      flash[:alert] = 'Incorrect value'
      redirect_to root_path
    end
  end
end
