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

ActiveRecord::Schema[8.1].define(version: 2026_10_07_065844) do
  create_table "breakdowns", force: :cascade do |t|
    t.string "title"
    t.text "lead"
    t.text "body"
    t.string "demo_key"
    t.datetime "published_at"
    t.integer "pattern_id", null: false
    t.integer "example_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["example_id"], name: "index_breakdowns_on_example_id"
    t.index ["pattern_id"], name: "index_breakdowns_on_pattern_id"
  end

  create_table "card_items", force: :cascade do |t|
    t.integer "kind"
    t.text "text"
    t.integer "position"
    t.integer "breakdown_id", null: false
    t.integer "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["breakdown_id"], name: "index_card_items_on_breakdown_id"
    t.index ["source_id"], name: "index_card_items_on_source_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "examples", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.text "description"
    t.integer "studio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id"], name: "index_examples_on_studio_id"
  end

  create_table "patterns", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.text "body"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_patterns_on_category_id"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.text "prompt"
    t.boolean "justified"
    t.text "explanation"
    t.integer "breakdown_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["breakdown_id"], name: "index_quiz_questions_on_breakdown_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "studios", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "breakdowns", "examples"
  add_foreign_key "breakdowns", "patterns"
  add_foreign_key "card_items", "breakdowns"
  add_foreign_key "card_items", "sources"
  add_foreign_key "examples", "studios"
  add_foreign_key "patterns", "categories"
  add_foreign_key "quiz_questions", "breakdowns"
end
