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

ActiveRecord::Schema.define(version: 20160423172002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "zip"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "active"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "banners", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "status"
    t.string   "link_to"
  end

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

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

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
    t.string   "shipping_method"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_item_id"], name: "index_order_items_on_product_item_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "address_id"
    t.string   "pre_tax_total"
    t.string   "tax_amount"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "product_items", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "description"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "status"
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
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "status"
    t.integer  "user_id"
    t.string   "admin_notes"
    t.string   "feature_one"
    t.string   "feature_two"
    t.string   "feature_three"
    t.string   "feature_four"
    t.string   "feature_five"
    t.integer  "total_orders"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "priority"
    t.string   "image_two_file_name"
    t.string   "image_two_content_type"
    t.integer  "image_two_file_size"
    t.datetime "image_two_updated_at"
    t.string   "image_three_file_name"
    t.string   "image_three_content_type"
    t.integer  "image_three_file_size"
    t.datetime "image_three_updated_at"
    t.string   "image_four_file_name"
    t.string   "image_four_content_type"
    t.integer  "image_four_file_size"
    t.datetime "image_four_updated_at"
    t.string   "image_five_file_name"
    t.string   "image_five_content_type"
    t.integer  "image_five_file_size"
    t.datetime "image_five_updated_at"
    t.string   "slug"
    t.string   "embedded_video"
    t.string   "video_status"
    t.string   "featured"
    t.string   "meta_keyword"
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
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "cart_items", "product_items"
  add_foreign_key "cart_items", "users"
  add_foreign_key "inventory", "products"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "product_items"
  add_foreign_key "orders", "users"
  add_foreign_key "product_items", "products"
end
