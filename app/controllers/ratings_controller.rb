class RatingsController < ApplicationController

  def create
    if params[:rating]
      point       = params[:rating][:point].to_i
      point_value = (1 <= point) && (point <= 7) ? true : false
      remote_ip   = request.remote_ip.to_s
    end

    if point_value
      @rating = Rating.new({ point: point, ip: remote_ip })

      if @rating.save
        flash[:notice] = 'Data Accepted'
        session[:vote_flag] = true
      else
        error_flash
      end
    else
      error_flash
    end

    redirect_to root_path
  end

  private
  def error_flash
    flash[:alert] = 'Incorrect value or You already voted'
  end
end
