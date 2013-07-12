class RatingsController < ApplicationController

  def create
    point       = params[:rating][:point].to_i
    point_value = (1 <= point) && (point <= 7) ? true : false
    remote_ip   = request.remote_ip.to_s

    if point_value
      @rating = Rating.new({ point: point, ip: remote_ip })

      if @rating.save
        flash[:notice] = 'Data Accepted'
      else
        error_flash
      end
    else
      error_flash
    end

    session[:vote_flag] = true
    redirect_to root_path
  end

  private
  def error_flash
    flash[:alert] = 'Incorrect value or You already voted'
  end
end
