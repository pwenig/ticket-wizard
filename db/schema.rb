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

ActiveRecord::Schema.define(version: 2018_12_30_202458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "attends", id: :serial, force: :cascade do |t|
    t.integer "attendee_id"
    t.integer "attended_event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attended_event_id"], name: "index_attends_on_attended_event_id"
    t.index ["attendee_id", "attended_event_id"], name: "index_attends_on_attendee_id_and_attended_event_id", unique: true
    t.index ["attendee_id"], name: "index_attends_on_attendee_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "user_id"
    t.text "body"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_comments_on_event_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.integer "category_id"
    t.string "event_guid"
    t.index ["category_id"], name: "index_events_on_category_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2
    t.string "order_ref"
    t.bigint "user_id"
    t.bigint "event_id"
    t.integer "purchased_ticket_ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_orders_on_event_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "purchased_tickets", force: :cascade do |t|
    t.string "ticket_guid"
    t.boolean "redeemed", default: false, null: false
    t.string "barcode"
    t.bigint "event_id"
    t.bigint "ticket_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_purchased_tickets_on_event_id"
    t.index ["ticket_id"], name: "index_purchased_tickets_on_ticket_id"
    t.index ["user_id"], name: "index_purchased_tickets_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "title"
    t.decimal "price", precision: 8, scale: 2
    t.integer "qty_available"
    t.text "description"
    t.datetime "onsale_start"
    t.datetime "onsale_end"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "stripe_publishable_key"
    t.string "stripe_secret_key"
    t.string "provider"
    t.string "uid"
    t.boolean "ops", default: false
  end

  add_foreign_key "comments", "events"
  add_foreign_key "events", "users"
  add_foreign_key "orders", "events"
  add_foreign_key "orders", "users"
  add_foreign_key "purchased_tickets", "events"
  add_foreign_key "purchased_tickets", "tickets"
  add_foreign_key "purchased_tickets", "users"
  add_foreign_key "tickets", "events"
end
