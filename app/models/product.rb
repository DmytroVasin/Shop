class Product < ActiveRecord::Base
  attr_accessible :description, :price, :title, :in_stock, :category_ids

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :in_stock, inclusion: { in: [true, false] }
  validates :title, length: { minimum: 10 }
  validates :description, length: { minimum: 100 }

  has_and_belongs_to_many :categories
end
