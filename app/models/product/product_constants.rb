module Product::ProductConstants

  MATERIAL = [
    ['Кожа','leather'],
    ['Полиэстер','polyester'],
    ['Искусств. кожа','faux_leather'],
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
    ['Искусств. замша','faux_suede'],
    ['Трикотажный','tricot'],
    ['Шелк','silk'],
    ['Шерсть','wool'],
    ['Деним','denim'],
    ['Зернистая кожа','full_grain_leather'],
    ['Резиновый','rubber'],
    ['Рафия','raffia'],
    ['Искусств. шелк','rayon'],
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
    ['Карман для ноут-а','laptop_sleeve'],
    ['Легкая','lightweight'],
    ['На колесиках','wheeled_bags'],
    ['С карабином','key_clip'],
    ['Увеличив. сумка','expandable_bags'],
    ['Карман для воды','hydration_pockets'],
    ['Карман для плеера','audio_pockets'],
    ['Замок TSA','tsa_locks'],
    ['Одобрено TSA ','tsa_approved'],
    ['Переработ. матер-л','recycled_materials'],
    ['Жестк. поверхность','hardside'],
    ['Светоотражающий','reflective'],
    ['Водоотталк-ющий','waterproof'],
    ['Изоляция','insulated'],
    ['Водостойкий','water_resistant'],
    ['Термо-карманы','cooler_pocket'],
    ['Для стирки','washable'],
    ['Двухсторонние','reversible']
  ]

  SORT_HASH = {
    'Лучшее' => 'best',
    'Цена по убыванию' => 'low',
    'цена по возрастанию' => 'high',
    'Новое' => 'newest'
  }

end
