# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_28_092402) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applied_jobs", force: :cascade do |t|
    t.bigint "job_listing_id", null: false
    t.bigint "talent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["job_listing_id"], name: "index_applied_jobs_on_job_listing_id"
    t.index ["talent_id"], name: "index_applied_jobs_on_talent_id"
  end

  create_table "job_listings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "requirements"
    t.decimal "salary"
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.string "status", default: "pending"
    t.index ["owner_id"], name: "index_job_listings_on_owner_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.float "wallet"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "applied_jobs", "job_listings"
  add_foreign_key "applied_jobs", "users", column: "talent_id"
  add_foreign_key "job_listings", "users", column: "owner_id"
  add_foreign_key "users", "roles"
end
