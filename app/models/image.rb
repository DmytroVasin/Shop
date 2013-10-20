class Image < ActiveRecord::Base
  attr_accessible :small, :middle, :large
  belongs_to :product
end
