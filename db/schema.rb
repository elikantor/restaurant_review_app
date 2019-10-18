# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 3) do

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "food_genre"
    t.string "location"
    t.integer "$rating"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "restaurant_id"
    t.string "content"
    t.integer "rating"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "favorite_food_genre"
    t.string "home_location"
    t.string "work_study_location"
  end

end
