class Category < ActiveRecord::Base
  attr_accessible :name, :category_rus

  validates :name, presence: true

  before_destroy {|category| category.products.clear}

  has_and_belongs_to_many :products

  include Category::CategoryScopes
end
