class Gender < ActiveRecord::Base
  attr_accessible :gender, :gender_rus
  has_and_belongs_to_many :products
end
