class Colour < ActiveRecord::Base
  attr_accessible :name, :name_rus, :common_colors

  serialize :common_colors, ActiveRecord::Coders::Hstore

  has_many :colors
  has_many :products, through: :colors, uniq: true
  has_many :images, through: :colors, uniq: true

  COMMON_COLORS_RUS = [
    ['Чёрный', 'Black'],
    ['Мульти', 'Multi'],
    ['Синий', 'Blue'],
    ['Коричневый', 'Brown'],
    ['Красный', 'Red'],
    ['Розовый', 'Pink'],
    ['Серый', 'Gray'],
    ['Зелёный', 'Green'],
    ['Коричневый', 'Tan'],
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
    ['Голубой', 'BlueGay']
  ]

end
