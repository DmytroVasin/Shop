class Image < ActiveRecord::Base
  attr_accessible :small, :middle, :large

  has_many :colors, dependent: :nullify
  has_many :products, through: :colors, uniq: true
  has_many :colours, through: :colors, uniq: true


  def self.choose_by_color color
    joins(:colours).where("common_colors ? :key", key: color )
  end

  def self.get_splited_representative_img
    last.middle.split('-')
  end

end
