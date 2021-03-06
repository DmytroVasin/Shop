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

ActiveRecord::Schema.define(:version => 20140529131736) do

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

  add_index "categories_products", ["category_id"], :name => "index_categories_products_on_category_id"
  add_index "categories_products", ["product_id"], :name => "index_categories_products_on_product_id"

  create_table "colors", :force => true do |t|
    t.integer  "colour_id"
    t.integer  "image_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "colors", ["colour_id"], :name => "index_colors_on_colour_id"
  add_index "colors", ["image_id"], :name => "index_colors_on_image_id"
  add_index "colors", ["product_id"], :name => "index_colors_on_product_id"

  create_table "colours", :force => true do |t|
    t.string "name"
    t.string "name_rus"
    t.hstore "common_colors"
    t.string "main"
  end

  add_index "colours", ["common_colors"], :name => "index_colours_on_common_colors"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

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

  add_index "genders_products", ["gender_id"], :name => "index_genders_products_on_gender_id"
  add_index "genders_products", ["product_id"], :name => "index_genders_products_on_product_id"

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
    t.decimal  "price",        :precision => 8, :scale => 2
    t.integer  "brand_id"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.integer  "rank",                                       :default => 0
    t.text     "video_href"
    t.text     "link_href"
    t.decimal  "old_price",    :precision => 8, :scale => 2
    t.boolean  "bestseller",                                 :default => false
    t.hstore   "materials"
    t.hstore   "zippers"
    t.hstore   "features"
    t.integer  "voters_count",                               :default => 0
    t.integer  "score",                                      :default => 0
  end

  add_index "products", ["brand_id"], :name => "index_products_on_brand_id"
  add_index "products", ["features"], :name => "index_products_on_features"
  add_index "products", ["materials"], :name => "index_products_on_materials"
  add_index "products", ["zippers"], :name => "index_products_on_zippers"

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
