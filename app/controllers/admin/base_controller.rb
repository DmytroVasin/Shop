class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'

  def index
    ratings          = Rating.all
    @count           = ratings.count
    hash_with_points = ratings.group_by(&:point)

    @hash_with_counts     = { '1' => 0, '2' => 0, '3' => 0, '4' => 0, '5' => 0, '6' => 0, '7' => 0 }
    @hash_with_percentege = { '1' => 0, '2' => 0, '3' => 0, '4' => 0, '5' => 0, '6' => 0, '7' => 0 }

    hash_with_points.each do |key, value|
      @hash_with_counts["#{key}"]     = value.count
      @hash_with_percentege["#{key}"] = (value.count * 100)/@count.to_f
    end
  end
end
