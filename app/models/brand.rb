class Brand < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many :products, dependent: :destroy

  include Brand::BrandConstants
end
