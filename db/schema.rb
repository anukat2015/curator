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

ActiveRecord::Schema.define(version: 20150207184329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "company_reports_by_earnings_yield", force: true do |t|
    t.string   "name"
    t.string   "symbol"
    t.string   "market_cap"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ebit"
    t.string   "ebit_date"
    t.string   "enterprise_value"
    t.string   "earnings_yield"
    t.string   "fixed_assets"
    t.string   "working_capital"
    t.string   "return_on_capital"
    t.string   "market_cap_date"
    t.string   "total_assets"
    t.string   "total_assets_date"
    t.string   "current_assets"
    t.string   "current_assets_date"
    t.string   "total_debt"
    t.string   "total_debt_date"
    t.string   "cash_and_equivalents"
    t.string   "cash_and_equivalents_date"
    t.string   "working_capital_date"
  end

  create_table "company_reports_by_return_on_capital", force: true do |t|
    t.string   "name"
    t.string   "symbol"
    t.string   "ebit"
    t.string   "ebit_date"
    t.string   "market_cap"
    t.string   "market_cap_date"
    t.string   "working_capital"
    t.string   "working_capital_date"
    t.string   "total_assets"
    t.string   "total_assets_date"
    t.string   "current_assets"
    t.string   "current_assets_date"
    t.string   "total_debt"
    t.string   "total_debt_date"
    t.string   "cash_and_equivalents"
    t.string   "cash_and_equivalents_date"
    t.string   "fixed_assets"
    t.string   "enterprise_value"
    t.string   "earnings_yield"
    t.string   "return_on_capital"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "symbol"
    t.float    "ebit"
    t.string   "ebit_date"
    t.float    "market_cap"
    t.string   "market_cap_date"
    t.float    "working_capital"
    t.string   "working_capital_date"
    t.float    "fixed_assets"
    t.float    "total_assets"
    t.string   "total_assets_date"
    t.float    "current_assets"
    t.string   "current_assets_date"
    t.float    "total_debt"
    t.string   "total_debt_date"
    t.float    "cash_and_equivalents"
    t.string   "cash_and_equivalents_date"
    t.float    "enterprise_value"
    t.float    "return_on_capital"
    t.float    "earnings_yield"
  end

end
