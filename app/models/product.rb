class Product < ActiveRecord::Base
  attr_accessible :description, :price, :title, :in_stock, :category_ids, :brand_id

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :in_stock, inclusion: { in: [true, false] }
  validates :title, length: { minimum: 10 }
  validates :description, length: { minimum: 10 }
  validates :rank, numericality: { only_integer: true }
  validates_presence_of :brand
  validates_presence_of :categories


  scope :newest, order('updated_at DESC')
  scope :high, order('price DESC')
  scope :low, order('price ASC')
  scope :best, order('rank DESC')

  scope :price_between, lambda { |min, max| where('price >= ? AND price <= ?', min, max) }

  scope :by_category_name, lambda { |catname| joins(:categories).where('categories.name = ?', catname) }


  has_and_belongs_to_many :categories
  belongs_to :brand
end
