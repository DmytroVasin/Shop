class Gender < ActiveRecord::Base
  attr_accessible :gender
  has_many :products
end
