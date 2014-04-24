class Colour < ActiveRecord::Base
  attr_accessible :name, :name_rus, :common_colors, :main

  serialize :common_colors, ActiveRecord::Coders::Hstore

  has_many :colors
  has_many :products, through: :colors, uniq: true
  has_many :images, through: :colors, uniq: true

  include Colour::ColourConstants
  include Colour::ColourScopes

end
