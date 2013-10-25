class Product < ActiveRecord::Base
  attr_accessible :description, :price, :title, :in_stock, :category_ids, :brand_id, :rank, :gender_ids, :color_ids, :video_href

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :in_stock, inclusion: { in: [true, false] }
  validates :rank, numericality: { only_integer: true }
  validates :brand, :categories, presence: true
  validates :title, uniqueness: { case_sensitive: false }


  scope :newest, order('updated_at DESC')
  scope :high, order('price DESC')
  scope :low, order('price ASC')
  scope :best, order('rank DESC')

  scope :price_between, lambda { |min, max| where('price >= ? AND price <= ?', min, max) }

  scope :by_gender, lambda { |g| joins(:genders).where('genders.gender = ?', g ) }
  scope :by_brands_name, lambda { |brandname| joins(:brand).where('brands.name = ?', brandname) }


  has_many :line_items
  has_and_belongs_to_many :images
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :genders
  has_and_belongs_to_many :colors
  belongs_to :brand

  accepts_nested_attributes_for :categories

  before_destroy :not_referenced_by_any_line_items

  private

  def not_referenced_by_any_line_items
    if line_items.empty?
      return true
    else
      errors.add(:base, 'cant destroy - line_items is present')
      return false
    end
  end



  def self.search(search)
    if search
      where('title like ?', "%#{search}%")
    else
      scoped
    end
  end

end
