class WelcomeController < ApplicationController
  def index
    @brands_left  = Brand.joins(:products).random_by_id_shuffle(10)
    @brands_right = Brand.joins(:products).random_by_id_shuffle(10)
  end

  def about_us
    @brands_left  = Brand.joins(:products).random_by_id_shuffle(10)
    @brands_right = Brand.joins(:products).random_by_id_shuffle(10)
  end

  def to_order
    @brands_left  = Brand.joins(:products).random_by_id_shuffle(10)
    @brands_right = Brand.joins(:products).random_by_id_shuffle(10)
  end

  def warranties
    @brands_left  = Brand.joins(:products).random_by_id_shuffle(10)
    @brands_right = Brand.joins(:products).random_by_id_shuffle(10)
  end

  def service
    @brands_left  = Brand.joins(:products).random_by_id_shuffle(10)
    @brands_right = Brand.joins(:products).random_by_id_shuffle(10)
  end

  def faqs
    @brands_left  = Brand.joins(:products).random_by_id_shuffle(10)
    @brands_right = Brand.joins(:products).random_by_id_shuffle(10)
  end
end
