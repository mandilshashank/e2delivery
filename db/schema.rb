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

ActiveRecord::Schema.define(version: 20170430000952) do

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "company_name"
    t.string   "account_num"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "company_email"
    t.text     "pickup_address",   limit: 65535
    t.string   "pickup_city"
    t.string   "pickup_zip"
    t.string   "pickup_company"
    t.string   "pickup_contact"
    t.string   "pickup_phone"
    t.text     "delivery_address", limit: 65535
    t.string   "delivery_city"
    t.string   "delivery_zip"
    t.string   "delivery_company"
    t.string   "delivery_contact"
    t.string   "delivery_phone"
    t.date     "pickup_date"
    t.time     "pickup_time"
    t.date     "delivery_date"
    t.time     "delivery_time"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
