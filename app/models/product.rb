class Product < ActiveRecord::Base
  attr_accessible :description, :price, :title, :category_ids, :brand_id, :rank, :gender_ids, :video_href, :link_href, :old_price, :bestseller, :colour_ids

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  validates :old_price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true

  validates :rank, numericality: { only_integer: true }
  validates :brand, :categories, presence: true
  validates :title, uniqueness: { case_sensitive: false }
  validate :price_must_be_gr_than_old_price


  scope :newest, -> { order('updated_at DESC') }
  scope :high, -> { order('price DESC') }
  scope :low, -> { order('price ASC') }
  scope :best, -> { order('rank DESC') }
  scope :by_gender, ->(g) { joins(:genders).where('genders.gender = ?', g ) }
  scope :count_of_best_sellers, -> { where(bestseller: true) }


  has_many :line_items
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :genders

  has_many :colors
  has_many :images, through: :colors, dependent: :nullify, uniq: true
  has_many :colours, through: :colors, dependent: :nullify, uniq: true


  belongs_to :brand

  accepts_nested_attributes_for :categories

  before_destroy :not_referenced_by_any_line_items

  def price_must_be_gr_than_old_price
    if self.old_price
      errors.add(:price, "must be greater then old price") if self.old_price.to_f <= self.price.to_f
    end
  end

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

# Scope's:

  def self.selecting_by(params_arr, type, ing = '', name = 'name')
    if params_arr
      where_query = "#{type}#{ing}.#{name} = ?"
      (params_arr.count - 1).times do
        where_query << " OR #{type}#{ing}.#{name} = ?"
      end

      query_full = []
      query_full = query_full.push(where_query)

      params_arr.each { |x| query_full.push(x) }

      joins(:"#{type}").where(query_full).uniq(&:id)
    else
      scoped
    end
  end

  def self.price_between(params_arr)
    if params_arr
      price_arr = params_arr.split(',')
      where("price between ? AND ?", price_arr[0], price_arr[1])
    else
      scoped
    end
  end

  def self.sort_direction(direction, hash_of_sort)
    if hash_of_sort.values.include? direction
      self.send(direction.to_sym)
    else
      scoped
    end
  end

  def self.selecting_by_color(colors)
    if colors
      joins(:colours).where("common_colors ?| ARRAY[:value]", value: colors).uniq(&:id)
    else
      scoped
    end
  end
end
