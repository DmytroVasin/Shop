class Colour < ActiveRecord::Base
  attr_accessible :name, :name_rus, :common_colors, :materials, :zippers, :features

  serialize :common_colors, ActiveRecord::Coders::Hstore
  serialize :materials, ActiveRecord::Coders::Hstore
  serialize :zippers, ActiveRecord::Coders::Hstore
  serialize :features, ActiveRecord::Coders::Hstore

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
    ['Голубой', 'BlueGay'],
  ]

  MATERIAL = [
    ['Кожа', 'skin'],
    ['Полиэстер', 'polyester'],
    ['Искусственная кожа', 'imitation_leather'],
    ['Нейлон', 'nylon'],
    ['Синтетика', 'synthetics'],
    ['Хлопок', 'cotton'],
    ['Брезент', 'tarpaulin'],
    ['Полиуретан', 'polyurethane'],
    ['Сетка', 'net'],
    ['Рипстоп', 'ripstop'],
    ['Винил', 'vinyl'],
    ['Атласный', 'satin'],
    ['Замша', 'suede'],
    ['Лакированная кожа', 'patent_leather'],
    ['Жаккард', 'jacquard'],
    ['Пластиковая', 'plastic'],
    ['Шерсть', 'wool'],
    ['Саржа', 'twill'],
    ['Лен', 'flax'],
    ['Соломенный', 'straw'],
    ['Конопляный', 'cannabic'],
    ['Искусственная замша', 'faux suede'],
    ['Трикотажный', 'knitted'],
    ['Шелк', 'silk'],
    ['Шерсть', 'wool'],
    ['Деним', 'denim'],
    ['Зернистая кожа', 'grainy_leather'],
    ['Резиновый', 'rubber'],
    ['Рафия', 'raffia'],
    ['Кожа ягненка', 'lamb_leather'],
    ['Искусственный шелк', 'rayon'],
    ['Змеиная кожа', 'snakeskin'],
    ['Джут', 'jute'],
    ['Микрофирба', 'mikrofirba'],
    ['Брезент', 'tarpaulin'],
    ['Войлок', 'felt'],
    ['Неопрен', 'neoprene'],
    ['Нубук', 'nubuck'],
    ['Овчина', 'sheepskin'],
    ['Твид', 'tweed'],
    ['Вельвет', 'corduroy'],
    ['Вышивка', 'embroidery'],
    ['Бриллиантовый', 'diamond'],
    ['Кружева', 'lace'],
    ['Полипропилен', 'polypropylene'],
    ['Ширлинг', 'shearling'],
    ['Силикон', 'silicone'],
    ['Вискоз', 'viscose']
  ]

  CLOSING_TYPE = [
    ['Молния', 'zipper'],
    ['Магнит', 'magnet'],
    ['Пряжка', 'buckle'],
    ['Поворотный замок', 'cam_lock'],
    ['Шнурок', 'lace'],
    ['Кнопка с фиксацией', 'button_with_fixation'],
    ['Пружинный замок', 'spring_lock'],
    ['Липучка', 'velcro'],
    ['Защелка', 'latch'],
    ['Кнопка', 'button']
  ]

  FEATURES = [
    ['Карман для ноутбука', 'for_laptop'],
    ['Легкая', 'easy'],
    ['На колесиках', 'on_wheels'],
    ['С карабином', 'with_carabiner'],
    ['Увеличивающаяся сумка', 'increasing_bag'],
    ['Карман для воды', 'for_water'],
    ['Карман для плеера', 'for_player'],
    ['Замок TSA', 'tsa_lock'],
    ['Одобрено TSA ', 'tsa_approved'],
    ['Переработанный материал', 'recycled_material'],
    ['Жесткая поверхность', 'rigid_surface'],
    ['Светоотражающий', 'reflective'],
    ['Водоотталкивающий', 'water_repellent'],
    ['Изоляция', 'insulation'],
    ['Водостойкий', 'water_resistant'],
    ['Термо-карманы', 'thermo_pockets'],
    ['Для стирки', 'laundry'],
    ['Двухсторонние', 'bilateral'],
    ['Веган', 'vegan']
  ]

  def self.create_hash_by(const, array)
    return nil if array.nil?
    Hash[array.map { |rus_color| [const.assoc(rus_color).last, rus_color ] }]
  end
end
