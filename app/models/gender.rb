class Gender < ActiveRecord::Base
  attr_accessible :gender
  has_and_belongs_to_many :products
end
