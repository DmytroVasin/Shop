class Colour < ActiveRecord::Base
  attr_accessible :name, :name_rus

  has_many :colors
  has_many :products, through: :colors
end
