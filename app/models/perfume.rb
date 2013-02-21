class Perfume < ActiveRecord::Base
  attr_accessible :description, :price, :title, :in_stock, :category_ids

  has_and_belongs_to_many :categories
end
