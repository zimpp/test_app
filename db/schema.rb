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

ActiveRecord::Schema[7.1].define(version: 2025_01_26_204739) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interests", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_interests_on_name", unique: true
  end

  create_table "interests_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "interest_id", null: false
    t.index ["user_id", "interest_id"], name: "index_interests_users_on_user_id_and_interest_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_skills_on_name", unique: true
  end

  create_table "skills_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skill_id", null: false
    t.index ["user_id", "skill_id"], name: "index_skills_users_on_user_id_and_skill_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "surname"
    t.string "patronymic"
    t.string "user_full_name"
    t.string "nationality"
    t.string "country"
    t.integer "gender"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
