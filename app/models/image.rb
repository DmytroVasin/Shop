class Image < ActiveRecord::Base
  attr_accessible :small, :middle, :large

  has_many :colors, dependent: :nullify
  has_many :products, through: :colors, uniq: true
  has_many :colours, through: :colors, uniq: true
end
