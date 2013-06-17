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

ActiveRecord::Schema.define(:version => 20130603080112) do

  create_table "admins", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "membergroups", :force => true do |t|
    t.string  "name"
    t.float   "fee"
    t.boolean "onetimefee"
  end

  create_table "members", :force => true do |t|
    t.string   "firstnames"
    t.string   "surname"
    t.string   "municipality"
    t.string   "address"
    t.string   "zipcode"
    t.string   "postoffice"
    t.string   "country"
    t.string   "email"
    t.integer  "membernumber"
    t.integer  "membergroup_id"
    t.integer  "membershipyear"
    t.boolean  "paymentstatus"
    t.date     "invoicedate"
    t.boolean  "deleted",        :default => false
    t.boolean  "lender",         :default => false
    t.boolean  "support",        :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "partners", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
