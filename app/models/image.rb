class Image < ActiveRecord::Base
  attr_accessible :small, :middle, :large

  has_many :colors, dependent: :nullify
  has_many :products, through: :colors
  has_many :colours, through: :colors
end
