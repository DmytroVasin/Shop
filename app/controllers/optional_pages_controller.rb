class OptionalPagesController < ApplicationController
  before_filter :set_brands

  def about_us
  end

  def to_order
  end

  def warranties
  end

  def service
  end

  def faqs
  end

  def security
  end

  def policy
  end

  private
  def set_brands
    @brands_left  = Brand.joins(:products).random_by_id_shuffle(10)
    @brands_right = Brand.joins(:products).random_by_id_shuffle(10)
  end
end
