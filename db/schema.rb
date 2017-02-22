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

ActiveRecord::Schema.define(version: 20170221225729) do

  create_table "regular_certificates", force: :cascade do |t|
    t.string   "subject"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "key_file_name"
    t.string   "key_content_type"
    t.integer  "key_file_size"
    t.datetime "key_updated_at"
    t.string   "ca_file_name"
    t.string   "ca_content_type"
    t.integer  "ca_file_size"
    t.datetime "ca_updated_at"
    t.string   "public_file_name"
    t.string   "public_content_type"
    t.integer  "public_file_size"
    t.datetime "public_updated_at"
  end

  create_table "root_certificates", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "key_file_name"
    t.string   "key_content_type"
    t.integer  "key_file_size"
    t.datetime "key_updated_at"
    t.string   "ca_file_name"
    t.string   "ca_content_type"
    t.integer  "ca_file_size"
    t.datetime "ca_updated_at"
  end

end
