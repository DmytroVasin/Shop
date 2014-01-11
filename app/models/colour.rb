class Colour < ActiveRecord::Base
  attr_accessible :name

  has_many :colors
  has_many :products, through: :colors
end
