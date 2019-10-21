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

ActiveRecord::Schema.define(version: 20160625062916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string  "name",          limit: 255, null: false
    t.string  "description",   limit: 255
    t.string  "thumbnail_url", limit: 255
    t.integer "price",         limit: 2,   null: false
    t.integer "menu_id"
    t.integer "restaurant_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "item_price_cents"
    t.integer  "total_price_cents"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string  "name",          limit: 255, null: false
    t.integer "restaurant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "total_cents"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "stripe_charge_id"
    t.string   "email"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.integer  "price_cents"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string  "name",        limit: 255, null: false
    t.string  "cuisine",     limit: 255, null: false
    t.integer "unit_number", limit: 2
    t.string  "street",      limit: 255, null: false
    t.string  "city",        limit: 255, null: false
    t.string  "province",    limit: 255, null: false
    t.string  "post_code",   limit: 255, null: false
    t.string  "country",     limit: 255, null: false
    t.integer "owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users_order_statuses", force: :cascade do |t|
    t.integer "order_id"
    t.string  "user_order", limit: 255
    t.integer "user_id"
    t.string  "status",     limit: 255, default: "Not Accepted"
  end

  add_foreign_key "items", "menus", name: "items_menu_id_fkey", on_delete: :cascade
  add_foreign_key "items", "restaurants", name: "items_restaurant_id_fkey", on_delete: :cascade
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "menus", "restaurants", name: "menus_restaurant_id_fkey", on_delete: :cascade
  add_foreign_key "products", "categories"
end
