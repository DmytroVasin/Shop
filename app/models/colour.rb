class Colour < ActiveRecord::Base
  attr_accessible :name, :name_rus, :common_colors

  serialize :common_colors, ActiveRecord::Coders::Hstore

  has_many :colors
  has_many :products, through: :colors, uniq: true

  COMMON_COLORS = [
    'Black',
    'Blue',
    'Multi',
    'Brown',
    'Red',
    'Gray',
    'Green',
    'Pink',
    'Beige',
    'Tan',
    'Purple',
    'White',
    'Gold',
    'Yellow',
    'Orange',
    'Burgundy',
    'Silver',
    'Navy',
    'Pewter',
    'Olive',
    'Bone',
    'Bronze',
    'Animal',
    'Khaki',
    'Taupe',
    'Metallic',
    'Coral',
    'Mahogany',
    'Neutral',
    'Clear',
  ]

end
