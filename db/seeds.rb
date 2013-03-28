# encoding: UTF-8

require 'populator'
require 'faker'

[Category, Product, Admin, Brand].each(&:delete_all)

require Rails.root.join('db/seeds/admins')
require Rails.root.join('db/seeds/categories')
require Rails.root.join('db/seeds/products')
require Rails.root.join('db/seeds/brands')

add_admin
Seeds.create_categories
add_brands
products_and_dependencies

puts 'Load seeds complite!'