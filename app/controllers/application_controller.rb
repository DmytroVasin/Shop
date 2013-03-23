class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :login_page?


  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  protected

  def login_page?
    false
  end
end
