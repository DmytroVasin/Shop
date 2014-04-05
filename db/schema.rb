# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140401163845) do

  create_table "admins", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true

  create_table "brands", :force => true do |t|
    t.string "name"
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "category_rus"
  end

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "colors", :force => true do |t|
    t.integer  "colour_id"
    t.integer  "image_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "colours", :force => true do |t|
    t.string "name"
    t.string "name_rus"
    t.hstore "common_colors"
    t.hstore "materials"
    t.hstore "zippers"
  end

  add_index "colours", ["common_colors"], :name => "index_colours_on_common_colors"
  add_index "colours", ["materials"], :name => "index_colours_on_materials"
  add_index "colours", ["zippers"], :name => "index_colours_on_zippers"

  create_table "genders", :force => true do |t|
    t.string   "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "gender_rus"
  end

  create_table "genders_products", :id => false, :force => true do |t|
    t.integer "gender_id"
    t.integer "product_id"
  end

  create_table "images", :force => true do |t|
    t.text "small"
    t.text "middle"
    t.text "large"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.integer  "quantity",                                 :default => 1
    t.decimal  "price",      :precision => 8, :scale => 2
    t.integer  "order_id"
    t.string   "color"
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "phone"
    t.string   "additional_phone"
    t.string   "address"
    t.string   "region"
    t.string   "city"
    t.string   "email"
    t.string   "delivery"
    t.text     "info"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "status",           :default => "Заказано"
    t.text     "adm_info"
    t.string   "payment_method",   :default => "0.1"
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.integer  "brand_id"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.integer  "rank",                                      :default => 0
    t.text     "video_href"
    t.text     "link_href"
    t.decimal  "old_price",   :precision => 8, :scale => 2
    t.boolean  "bestseller",                                :default => false
  end

  create_table "ratings", :force => true do |t|
    t.string   "point"
    t.string   "ip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.string   "full_name"
    t.string   "address"
    t.string   "url_id"
    t.text     "delivery_time"
    t.text     "quality"
    t.text     "suggestions"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
