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

ActiveRecord::Schema.define(:version => 20120110071216) do

  create_table "doctors", :force => true do |t|
    t.string   "code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "designation"
    t.string   "email"
    t.string   "cell"
    t.string   "phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "postal"
    t.string   "city"
    t.string   "state"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doctors", ["user_id"], :name => "doctors_user_id_fk"

  create_table "patients", :force => true do |t|
    t.string   "refrence_no"
    t.string   "initial_name"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "test_execution_date"
    t.date     "test_delivery_date"
    t.decimal  "total_amount",               :precision => 6, :scale => 2
    t.decimal  "advance_payment",            :precision => 6, :scale => 2
    t.boolean  "is_doctor_receoved_payment"
    t.integer  "doctor_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patients", ["doctor_id"], :name => "patients_doctor_id_fk"
  add_index "patients", ["user_id"], :name => "patients_user_id_fk"

  create_table "test_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_active"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "test_categories", ["user_id"], :name => "test_categories_user_id_fk"

  create_table "tests", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.decimal  "fees",             :precision => 10, :scale => 0
    t.string   "commission_type"
    t.decimal  "commission_value", :precision => 10, :scale => 0
    t.text     "description"
    t.boolean  "is_active"
    t.integer  "user_id"
    t.integer  "test_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tests", ["test_category_id"], :name => "tests_test_category_id_fk"
  add_index "tests", ["user_id"], :name => "tests_user_id_fk"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "doctors", "users", :name => "doctors_user_id_fk"

  add_foreign_key "patients", "doctors", :name => "patients_doctor_id_fk"
  add_foreign_key "patients", "users", :name => "patients_user_id_fk"

  add_foreign_key "test_categories", "users", :name => "test_categories_user_id_fk"

  add_foreign_key "tests", "test_categories", :name => "tests_test_category_id_fk"
  add_foreign_key "tests", "users", :name => "tests_user_id_fk"

end
