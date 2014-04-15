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

  serialize :materials, ActiveRecord::Coders::Hstore
  serialize :zippers, ActiveRecord::Coders::Hstore
  serialize :features, ActiveRecord::Coders::Hstore

  MATERIAL = [
    ['Кожа','leather'],
    ['Полиэстер','polyester'],
    ['Искусственная кожа','faux_leather'],
    ['Нейлон','nylon'],
    ['Синтетика','synthetic'],
    ['Хлопок','cotton'],
    ['Брезент','canvas'],
    ['Полиуретан','polyurethane'],
    ['Сетка','mesh'],
    ['Рипстоп','ripstop'],
    ['Винил','vinyl'],
    ['Атласный','satin'],
    ['Замша','suede'],
    ['Лакированная кожа','patent_leather'],
    ['Жаккард','jacquard'],
    ['Пластиковая','plastic'],
    ['Флис','fleece'],
    ['Саржа','twill'],
    ['Лен','linen'],
    ['Соломенный','straw'],
    ['Конопляный','hemp'],
    ['Искусственная замша','faux_suede'],
    ['Трикотажный','tricot'],
    ['Шелк','silk'],
    ['Шерсть','wool'],
    ['Деним','denim'],
    ['Зернистая кожа','full_grain_leather'],
    ['Резиновый','rubber'],
    ['Рафия','raffia'],
    ['Искусственный шелк','rayon'],
    ['Змеиная кожа','snakeskin'],
    ['Джут','jute'],
    ['Микрофирба','microfiber'],
    ['Неопрен','neoprene'],
    ['Нубук','nubuk'],
    ['Твид','tweed'],
    ['Вельвет','velvet'],
    ['Вышивка','crochet'],
    ['Кружева','lace'],
    ['Латунный','brass'],
    ['Фланелевый','flannel'],
    ['Наппа','nappa'],
    ['Винтажная кожа','distressed_leather'],
    ['Овечья шерсть','shearling'],
    ['Ящерица','lizard'],
    ['Полиэтилен','polyethylene'],
    ['Волос животных','hair_calf'],
    ['Кордура','cordura'],
    ['Шагреневая кожа','pebbled_leather']
  ]

  CLOSING_TYPE = [
    ['Молния' ,'zipper'],
    ['Защелка' ,'snap'],
    ['Магнит' ,'magnetic'],
    ['Бакля' ,'buckle'],
    ['Поворотный замок' ,'twist_lock'],
    ['Шнурок' ,'drawstring'],
    ['Кнопка с фиксацией' ,'push_lock'],
    ['Пружинный замок' ,'clasp_lock'],
    ['Липучка' ,'hook_and_loop'],
    ['Резинка' ,'Bungee'],
    ['Кнопка' ,'Button']
  ]


  FEATURES = [
    ['Карман для ноутбука','laptop_sleeve'],
    ['Легкая','lightweight'],
    ['На колесиках','wheeled_bags'],
    ['С карабином','key_clip'],
    ['Увеличивающаяся сумка','expandable_bags'],
    ['Карман для воды','hydration_pockets'],
    ['Карман для плеера','audio_pockets'],
    ['Замок TSA','tsa_locks'],
    ['Одобрено TSA ','tsa_approved'],
    ['Переработанный материал','recycled_materials'],
    ['Жесткая поверхность','hardside'],
    ['Светоотражающий','reflective'],
    ['Водоотталкивающий','waterproof'],
    ['Изоляция','insulated'],
    ['Водостойкий','water_resistant'],
    ['Термо-карманы','cooler_pocket'],
    ['Для стирки','washable'],
    ['Двухсторонние','reversible']
  ]

  def price_must_be_gr_than_old_price
    if self.old_price
      errors.add(:price, "must be greater then old price") if self.old_price.to_f <= self.price.to_f
    end
  end

  def to_param
    "#{id}-#{title}".parameterize
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
      where("common_colors ?| ARRAY[:value]", value: colors).uniq(&:id)
    else
      scoped
    end
  end

  def self.selecting_by_zipper(zippers)
    if zippers
      where("zippers ?| ARRAY[:value]", value: zippers).uniq(&:id)
    else
      scoped
    end
  end

  def self.selecting_by_material(materials)
    if materials
      where("materials ?| ARRAY[:value]", value: materials).uniq(&:id)
    else
      scoped
    end
  end

  def self.selecting_by_features(features)
    if features
      where("features ?| ARRAY[:value]", value: features).uniq(&:id)
    else
      scoped
    end
  end
end
