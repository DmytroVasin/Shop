# encoding: UTF-8

require 'populator'
require 'faker'

[Category, Product, Admin, Brand, Gender].each(&:delete_all)

require Rails.root.join('db/seeds/admins')
require Rails.root.join('db/seeds/categories')
require Rails.root.join('db/seeds/gender')
require Rails.root.join('db/seeds/brands')
require Rails.root.join('db/seeds/products')

add_admin
Seeds.create_categories
add_brands
add_gender
products_and_dependencies

puts 'Load seeds complite!'
