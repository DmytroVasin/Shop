class Image < ActiveRecord::Base
  attr_accessible :small, :middle, :large
  has_and_belongs_to_many :product
end
