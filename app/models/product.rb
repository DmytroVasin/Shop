class Product < ActiveRecord::Base
  attr_accessible :description, :price, :title, :in_stock, :category_ids

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :in_stock, inclusion: { in: [true, false] }
  validates :title, length: { minimum: 10 }
  validates :description, length: { minimum: 100 }
  validates :rank, numericality: { only_integer: true }

  scope :new, order('updated_at DESC')
  scope :high, order('price DESC')
  scope :low, order('price ASC')
  scope :best, order('rank DESC')

  #scope :by_lower_price, lambda { |price| where('price < ?', price) }
  #scope :in_stock, where(in_stock: true)
  has_and_belongs_to_many :categories
end
