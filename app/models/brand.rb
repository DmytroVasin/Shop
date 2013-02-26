class Brand < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  before_destroy {|brand| brand.products.clear}

  has_many :products
end
