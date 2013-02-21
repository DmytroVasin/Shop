def products_and_dependencies
  perfume = Product.create(title:       'Acqua Di Gio',
                           description: 'Acqua Di Gio is a fresh and sensual fragrance for men by Giorgio Armani.
                                         This aquatic aromatic fragrance evokes a refreshing ocean breeze with its
                                         combination of lavender, juniper, freesia, cumin and ylang-ylang, jasmine,
                                         sandalwood and amber to create a fresh masculine scent thats perfect for day
                                         wear. Acqua Di Gio is available in eau de toilette spray and comes in a classic bottle.',
                           price:       10.85,
                           in_stock:    true)

  category_1 = Category.first
  perfume.categories  << category_1
end