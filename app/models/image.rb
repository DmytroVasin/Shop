class Image < ActiveRecord::Base
  attr_accessible :small, :middle, :large

  has_many :colors
  has_many :products, through: :colors
end
