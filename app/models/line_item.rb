class LineItem < ActiveRecord::Base
  attr_accessible :cart, :product_id, :price, :color

  belongs_to :product
  belongs_to :cart
  belongs_to :order

  validates :color, presence: true

  default_scope { order('created_at ASC') }
end
