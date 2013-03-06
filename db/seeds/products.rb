def products_and_dependencies
  category_1 = Category.first
  category_2 = Category.last
  brand      = Brand.first

  perfume = Product.create!(title:        'Acqua Di Gio',
                            description:  'Acqua Di Gio is a fresh and sensual fragrance for men by Giorgio Armani.
                                         This aquatic aromatic fragrance evokes a refreshing ocean breeze with its
                                         combination of lavender, juniper, freesia, cumin and ylang-ylang, jasmine,
                                         sandalwood and amber to create a fresh masculine scent thats perfect for day
                                         wear. Acqua Di Gio is available in eau de toilette spray and comes in a classic bottle.',
                            price:        10.85,
                            rank:         1,
                            in_stock:     true,
                            brand_id:     brand.id,
                            category_ids: Category.first.id)

  perfume.categories << category_1


  perfume = Product.create!(title:        'Eternity Eau De Parfum',
                            description:  'Eternity by Calvin Klein is a popular womens fragrance. Fresh fruit notes of mandarin blend
                                         with a floral background of lily of the valley, freesia, marigold, white lily, jasmine and
                                         rose together with a sultry base of sandalwood, patchouli, amber and musk to create a sexy
                                         and romantic day time scent for women of all ages. Available in a stylish eau de parfum
                                         spray bottle.',
                            price:        20.50,
                            rank:         2,
                            in_stock:     true,
                            brand_id:     brand.id,
                            category_ids: Category.first.id)

  perfume.categories << category_2


  perfume = Product.create!(title:        'Amy Childs Eau De Toilette',
                            description:  'Amy Childs debut fruity and floral fragrance opens with gloriously exotic notes of pomegranate
                                         seed, fresh green leaves and kumquat, moving into a floral heart of lotus, champaca and purple
                                         orchid. The gorgeous fragrance then dries down onto a sensual base of purple violet, amber,
                                         skin musks, soft woods and vanilla. Amy Childs feminine scent is also encased in an adorable
                                         deep purple, multi-faceted bottle embellished with a heart shaped charm.',
                            price:        80,
                            rank:         3,
                            in_stock:     false,
                            brand_id:     brand.id,
                            category_ids: Category.first.id)
  perfume.categories << category_2
end