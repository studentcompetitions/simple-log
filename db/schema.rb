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

ActiveRecord::Schema.define(version: 20151014145443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "work_days", force: :cascade do |t|
    t.integer  "work_month_id", null: false
    t.integer  "absence"
    t.integer  "hours"
    t.date     "date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "work_days", ["work_month_id"], name: "index_work_days_on_work_month_id", using: :btree

  create_table "work_months", force: :cascade do |t|
    t.integer  "year"
    t.integer  "month"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "employee_id", null: false
  end

  add_index "work_months", ["employee_id"], name: "index_work_months_on_employee_id", using: :btree

end
