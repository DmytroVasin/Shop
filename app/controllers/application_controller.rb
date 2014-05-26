class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :login_page?, :current_cart
  before_filter :clear_session

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end


  def create_hash_by(const, array)
    return nil if array.nil?
    Hash[array.map { |rus_color| [const.assoc(rus_color).last, rus_color ] }]
  end

  protected

  def vote_rank(hash_with_points, count)
    hash_with_counts     = { '1' => 0, '2' => 0, '3' => 0, '4' => 0, '5' => 0, '6' => 0, '7' => 0 }
    hash_with_percentege = hash_with_counts

    hash_with_points.each do |key, value|
      hash_with_counts["#{key}"]     = value.count
      hash_with_percentege["#{key}"] = (value.count * 100)/count.to_f
    end

    return hash_with_counts, hash_with_percentege
  end

  def clear_session
    reset_session
  end
end
