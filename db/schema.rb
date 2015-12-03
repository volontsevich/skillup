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

ActiveRecord::Schema.define(version: 20151201124105) do

  create_table "questions", force: :cascade do |t|
    t.integer  "survey_id",  limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "option",     limit: 4
    t.string   "meta",       limit: 255
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree

  create_table "responds", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.text     "content",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "survey_id",   limit: 4
    t.integer  "user_id",     limit: 4
  end

  add_index "responds", ["question_id"], name: "index_responds_on_question_id", using: :btree
  add_index "responds", ["survey_id"], name: "index_responds_on_survey_id", using: :btree
  add_index "responds", ["user_id"], name: "index_responds_on_user_id", using: :btree

  create_table "survey_mails", force: :cascade do |t|
    t.integer  "survey_id",  limit: 4
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "survey_mails", ["survey_id"], name: "index_survey_mails_on_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.date     "send_date"
    t.date     "start_date"
    t.date     "exp_date"
    t.integer  "user_id",    limit: 4
  end

  add_index "surveys", ["user_id"], name: "index_surveys_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "admin",                              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "questions", "surveys"
  add_foreign_key "responds", "questions"
  add_foreign_key "responds", "surveys"
  add_foreign_key "responds", "users"
  add_foreign_key "survey_mails", "surveys"
  add_foreign_key "surveys", "users"
end
