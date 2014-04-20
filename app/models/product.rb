class Product < ActiveRecord::Base
  attr_accessible :description,
                  :price,
                  :title,
                  :category_ids,
                  :brand_id,
                  :rank,
                  :gender_ids,
                  :video_href,
                  :link_href,
                  :old_price,
                  :bestseller,
                  :colour_ids,
                  :materials,
                  :zippers,
                  :features

  delegate :name, to: :brand, prefix: :brand

  has_many :line_items
  has_many :colors
  has_many :images, through: :colors, dependent: :nullify, uniq: true
  has_many :colours, through: :colors, dependent: :nullify, uniq: true
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :genders

  belongs_to :brand

  accepts_nested_attributes_for :categories

  serialize :materials, ActiveRecord::Coders::Hstore
  serialize :zippers, ActiveRecord::Coders::Hstore
  serialize :features, ActiveRecord::Coders::Hstore

  include Product::ProductScopes
  include Product::ProductValidations
  include Product::ProductCallbacks
  include Product::ProductConstants

  def to_param
    "#{id}-#{title}".parameterize
  end

end
