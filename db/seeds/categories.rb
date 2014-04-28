module Seeds
  def create_categories
    {
      'Handbags' => 'Ручная кладь',
      'Backpacks' => 'Сумка через плечо',
      'Luggage' => 'Багаж',
      'Wallets & Accessories' => 'Кошельки',
      'Duffle Bags' => 'Спортивная',
      'Laptop Bags' => 'Сумка для ноут-а',
      'Briefcases' => 'Портфель',
      'Lumbar Packs' => 'Поясничная сумка',
      'Bags & Packs' => 'Пакеты',
      'Makeup' => 'Косметичка'
    }.each do |en, rus|
      Category.create(name: en, category_rus: rus)
    end
  end

  module_function :create_categories
end
