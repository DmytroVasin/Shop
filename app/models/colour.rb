class Colour < ActiveRecord::Base
  attr_accessible :name, :name_rus, :common_colors

  serialize :common_colors, ActiveRecord::Coders::Hstore

  has_many :colors
  has_many :products, through: :colors, uniq: true

  COMMON_COLORS_RUS = [
    ['Чёрный', 'Black'],
    ['Мульти', 'Multi'],
    ['Синий', 'Blue'],
    ['Коричневый', 'Brown'],
    ['Красный', 'Red'],
    ['Розовый', 'Pink'],
    ['Серый', 'Gray'],
    ['Зелёный', 'Green'],
    ['Желтовато-коричневый', 'Tan'],
    ['Белый', 'White'],
    ['Бежевый', 'Beige'],
    ['Оранжевый', 'Orange'],
    ['Пурпурный', 'Purple'],
    ['Желтый', 'Yellow'],
    ['Золотой', 'Gold'],
    ['Бургундский', 'Burgundy'],
    ['Серебряный', 'Silver'],
    ['Бронзовый', 'Bronze'],
    ['Тёмно-Серый', 'DarkGray'],
    ['Оливковый', 'Olive'],
    ['Хаки', 'Khaki'],
    ['Оловянный', 'Pewter'],
    ['Коралловый', 'Coral'],
    ['Металик', 'Metallic'],
    ['Животный рисунок', 'Animal'],
    ['Нейтральный', 'Clear'],
    ['Голубой', 'BlueGay'],
  ]

  def self.create_hash_by(array)
    Hash[array.map { |rus_color| [COMMON_COLORS_RUS.assoc(rus_color).last, rus_color ] }]
  end
end
