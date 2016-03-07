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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160307192512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "quantity"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "affiliate_id"
    t.integer  "product_item_id"
  end

  add_index "cart_items", ["product_item_id"], name: "index_cart_items_on_product_item_id", using: :btree
  add_index "cart_items", ["user_id"], name: "index_cart_items_on_user_id", using: :btree

  create_table "inventory", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "size"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "inventory", ["product_id"], name: "index_inventory_on_product_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.integer  "affiliate_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "shipping_number"
    t.integer  "status"
    t.integer  "product_item_id"
    t.integer  "quantity"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_item_id"], name: "index_order_items_on_product_item_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "product_items", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "description"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "product_items", ["product_id"], name: "index_product_items_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "category"
    t.string   "price"
    t.integer  "model"
    t.string   "size"
    t.string   "picture"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "status"
    t.integer  "user_id"
    t.string   "admin_notes"
    t.string   "feature_one"
    t.string   "feature_two"
    t.string   "feature_three"
    t.string   "feature_four"
    t.string   "feature_five"
    t.integer  "total_orders"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "status"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
  end

  add_foreign_key "cart_items", "product_items"
  add_foreign_key "cart_items", "users"
  add_foreign_key "inventory", "products"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "product_items"
  add_foreign_key "orders", "users"
  add_foreign_key "product_items", "products"
end
