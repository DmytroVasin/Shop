class Category < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  before_destroy {|category| category.products.clear}

  has_and_belongs_to_many :products
end
