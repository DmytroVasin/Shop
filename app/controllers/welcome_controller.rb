class WelcomeController < ApplicationController
  def index
    @brands_left  = Brand.joins(:products).random_by_id_shuffle(10)
    @brands_right = Brand.joins(:products).random_by_id_shuffle(10)
  end
end
