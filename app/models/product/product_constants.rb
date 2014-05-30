module Product::ProductConstants

  MATERIAL = [
    ["Атласный", "satin"],
    ["Брезент", "canvas"],
    ["Вельвет", "velvet"],
    ["Винил", "vinyl"],
    ["Винтажная кожа", "distressed_leather"],
    ["Волос животных", "hair_calf"],
    ["Вышивка", "crochet"],
    ["Деним", "denim"],
    ["Джут", "jute"],
    ["Жаккард", "jacquard"],
    ["Замша", "suede"],
    ["Зернистая кожа", "full_grain_leather"],
    ["Змеиная кожа", "snakeskin"],
    ["Искусств. замша", "faux_suede"],
    ["Искусств. кожа", "faux_leather"],
    ["Искусств. шелк", "rayon"],
    ["Кожа", "leather"],
    ["Конопляный", "hemp"],
    ["Кордура", "cordura"],
    ["Кружева", "lace"],
    ["Лакированная кожа", "patent_leather"],
    ["Латунный", "brass"],
    ["Лен", "linen"],
    ["Микрофирба", "microfiber"],
    ["Наппа", "nappa"],
    ["Нейлон", "nylon"],
    ["Неопрен", "neoprene"],
    ["Нубук", "nubuk"],
    ["Овечья шерсть", "shearling"],
    ["Пластиковая", "plastic"],
    ["Полиуретан", "polyurethane"],
    ["Полиэстер", "polyester"],
    ["Полиэтилен", "polyethylene"],
    ["Рафия", "raffia"],
    ["Резиновый", "rubber"],
    ["Рипстоп", "ripstop"],
    ["Саржа", "twill"],
    ["Сетка", "mesh"],
    ["Синтетика", "synthetic"],
    ["Соломенный", "straw"],
    ["Твид", "tweed"],
    ["Трикотажный", "tricot"],
    ["Фланелевый", "flannel"],
    ["Флис", "fleece"],
    ["Хлопок", "cotton"],
    ["Шагреневая кожа", "pebbled_leather"],
    ["Шелк", "silk"],
    ["Шерсть", "wool"],
    ["Ящерица", "lizard"]
  ]

  CLOSING_TYPE = [
    ["Бакля", "buckle"],
    ["Защелка", "snap"],
    ["Кнопка", "Button"],
    ["Кнопка с фиксацией", "push_lock"],
    ["Липучка", "hook_and_loop"],
    ["Магнит", "magnetic"],
    ["Молния", "zipper"],
    ["Поворотный замок", "twist_lock"],
    ["Пружинный замок", "clasp_lock"],
    ["Резинка", "Bungee"],
    ["Шнурок", "drawstring"]
  ]

  FEATURES = [
    ["Водоотталк-ющий", "waterproof"],
    ["Водостойкий", "water_resistant"],
    ["Двухсторонние", "reversible"],
    ["Для стирки", "washable"],
    ["Жестк. поверхность", "hardside"],
    ["Замок TSA", "tsa_locks"],
    ["Изоляция", "insulated"],
    ["Карман для воды", "hydration_pockets"],
    ["Карман для ноут-а", "laptop_sleeve"],
    ["Карман для плеера", "audio_pockets"],
    ["Легкая", "lightweight"],
    ["На колесиках", "wheeled_bags"],
    ["Одобрено TSA ", "tsa_approved"],
    ["Переработ. матер-л", "recycled_materials"],
    ["С карабином", "key_clip"],
    ["Светоотражающий", "reflective"],
    ["Термо-карманы", "cooler_pocket"],
    ["Увеличив. сумка", "expandable_bags"]
  ]

  SORT_HASH = {
    'Лучшее' => 'best',
    'Цена по убыванию' => 'low',
    'Цена по возрастанию' => 'high',
    'Новое' => 'newest'
  }

end
