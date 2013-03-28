class LineItem < ActiveRecord::Base
  attr_accessible :cart, :product_id, :price

  belongs_to :product
  belongs_to :cart
  belongs_to :order

  default_scope { order('created_at ASC') }
end
