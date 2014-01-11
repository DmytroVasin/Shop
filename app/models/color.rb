class Color < ActiveRecord::Base
  attr_accessible :image_id, :colour_id

  belongs_to :product
  belongs_to :image
  belongs_to :colour
end
