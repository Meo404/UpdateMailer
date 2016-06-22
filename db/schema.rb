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

ActiveRecord::Schema.define(version: 20160616214102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ahoy_messages", force: :cascade do |t|
    t.string   "token"
    t.text     "to"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "mailer"
    t.text     "subject"
    t.text     "content"
    t.datetime "sent_at"
    t.datetime "opened_at"
    t.datetime "clicked_at"
  end

  add_index "ahoy_messages", ["token"], name: "index_ahoy_messages_on_token", using: :btree
  add_index "ahoy_messages", ["user_id", "user_type"], name: "index_ahoy_messages_on_user_id_and_user_type", using: :btree

  create_table "distribution_lists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "distribution_lists_emails", id: false, force: :cascade do |t|
    t.integer "email_id",             null: false
    t.integer "distribution_list_id", null: false
  end

  add_index "distribution_lists_emails", ["distribution_list_id", "email_id"], name: "idx_distribution_list_email", using: :btree
  add_index "distribution_lists_emails", ["email_id", "distribution_list_id"], name: "idx_email_distribution_list", using: :btree

  create_table "distribution_lists_update_mails", id: false, force: :cascade do |t|
    t.integer "update_mail_id",       null: false
    t.integer "distribution_list_id", null: false
  end

  add_index "distribution_lists_update_mails", ["distribution_list_id", "update_mail_id"], name: "idx_distribution_list_update_mail", using: :btree
  add_index "distribution_lists_update_mails", ["update_mail_id", "distribution_list_id"], name: "idx_update_mail_distribution_list", using: :btree

  create_table "email_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "template"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "preview_image_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "update_mail_views", force: :cascade do |t|
    t.integer  "update_mail_id"
    t.string   "user_agent"
    t.string   "browser"
    t.string   "browser_version"
    t.string   "os"
    t.string   "os_version"
    t.string   "device_name"
    t.string   "device_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "update_mail_views", ["update_mail_id"], name: "index_update_mail_views_on_update_mail_id", using: :btree

  create_table "update_mails", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "permalink"
    t.boolean  "sent"
    t.datetime "sent_at"
    t.boolean  "public",                  default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "update_mail_views_count", default: 0
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "update_mail_views", "update_mails"
end
