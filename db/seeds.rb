# encoding: UTF-8

require Rails.root.join('db/seeds/admins')
require Rails.root.join('db/seeds/categories')
require Rails.root.join('db/seeds/products')
require Rails.root.join('db/seeds/brands')

add_admins
Seeds.create_categories
add_brands
products_and_dependencies

puts 'Load seeds complite!'