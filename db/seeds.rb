# encoding: UTF-8

require 'populator'
require 'faker'

[Category, Product, Admin, Brand, Gender, Color, Image].each(&:delete_all)

require Rails.root.join('db/seeds/admins')
require Rails.root.join('db/seeds/categories')
require Rails.root.join('db/seeds/gender')
require Rails.root.join('db/seeds/brands')
require Rails.root.join('db/seeds/colors_and_image')
require Rails.root.join('db/seeds/products')

add_admin
Seeds.create_categories
add_brands
add_gender
add_colors_and_image
products_and_dependencies

puts 'Load seeds complite!'
