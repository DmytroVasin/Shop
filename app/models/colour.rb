class Colour < ActiveRecord::Base
  attr_accessible :name, :name_rus, :common_colors

  serialize :common_colors, ActiveRecord::Coders::Hstore

  has_many :colors
  has_many :products, through: :colors, uniq: true

  COMMON_COLORS_RUS = [
    ['Черный', 'Black'],
    ['Синий', 'Blue'],
    ['Мульти', 'Multi'],
    ['Коричневый', 'Brown'],
    ['Красный', 'Red'],
    ['Серый', 'Gray'],
    ['Зеленый', 'Green'],
    ['Розовый', 'Pink'],
    ['Бежевый', 'Beige'],
    ['Кожа', 'Tan'],
    ['Пурпурный', 'Purple'],
    ['Белый', 'White'],
    ['Золотой', 'Gold'],
    ['Желтый', 'Yellow'],
    ['Оранжевый', 'Orange'],
    ['Бордовый', 'Burgundy'],
    ['Серебряный', 'Silver'],
    ['НАВИ', 'Navy'],
    ['Олово', 'Pewter'],
    ['Оливковый', 'Olive'],
    ['Кость', 'Bone'],
    ['Бронза', 'Bronze'],
    ['Животный', 'Animal'],
    ['Хаки', 'Khaki'],
    ['Тауп', 'Taupe'],
    ['Металик', 'Metallic'],
    ['Корал', 'Coral'],
    ['Красное дерево', 'Mahogany'],
    ['Натуральный', 'Neutral'],
    ['Чистый', 'Clear'],
  ]

end
