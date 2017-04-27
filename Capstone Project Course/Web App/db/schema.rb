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

ActiveRecord::Schema.define(version: 20161120231903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booked_hours", force: :cascade do |t|
    t.integer  "id_event_date"
    t.integer  "id_user"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "days", force: :cascade do |t|
    t.string   "day"
    t.string   "spanish_day"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "event_dates", force: :cascade do |t|
    t.integer  "event_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "host_id"
    t.string   "location"
    t.integer  "capacity"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "remaining_capacity"
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "event_type_id"
    t.integer  "host_id"
    t.integer  "faculty_id"
    t.string   "location"
    t.integer  "capacity"
    t.integer  "created_by"
    t.datetime "start_hour"
    t.datetime "end_hour"
    t.integer  "day_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "faculties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_sequences", force: :cascade do |t|
    t.integer  "infographic_id"
    t.integer  "image_id"
    t.integer  "order"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["image_id"], name: "index_image_sequences_on_image_id", using: :btree
    t.index ["infographic_id"], name: "index_image_sequences_on_infographic_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "added_by"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "image_file_file_name"
    t.string   "image_file_content_type"
    t.integer  "image_file_file_size"
    t.datetime "image_file_updated_at"
  end

  create_table "images_themes", id: false, force: :cascade do |t|
    t.integer "image_id", null: false
    t.integer "theme_id", null: false
    t.index ["image_id", "theme_id"], name: "index_images_themes_on_image_id_and_theme_id", using: :btree
  end

  create_table "infographics", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "added_by"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "infographics_topics", id: false, force: :cascade do |t|
    t.integer "infographic_id", null: false
    t.integer "topic_id",       null: false
    t.index ["infographic_id", "topic_id"], name: "index_infographics_topics_on_infographic_id_and_topic_id", using: :btree
  end

  create_table "logs", force: :cascade do |t|
    t.datetime "date"
    t.integer  "user_id"
    t.integer  "media_id"
    t.string   "media_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_type", "media_id"], name: "index_logs_on_media_type_and_media_id", using: :btree
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "added_by"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sleep_surveys", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "p1"
    t.float    "p2"
    t.string   "p3"
    t.string   "p4"
    t.string   "p5"
    t.string   "p6"
    t.string   "p7"
    t.string   "p8"
    t.string   "p9"
    t.string   "p10"
    t.string   "p11"
    t.string   "p12"
    t.string   "result"
    t.integer  "score"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "recommendations"
  end

  create_table "sound_sequences", force: :cascade do |t|
    t.integer  "program_id"
    t.integer  "sound_id"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_sound_sequences_on_program_id", using: :btree
    t.index ["sound_id"], name: "index_sound_sequences_on_sound_id", using: :btree
  end

  create_table "sounds", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "added_by"
    t.integer  "duration"
    t.boolean  "program"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "sound_file_file_name"
    t.string   "sound_file_content_type"
    t.integer  "sound_file_file_size"
    t.datetime "sound_file_updated_at"
  end

  create_table "sounds_themes", id: false, force: :cascade do |t|
    t.integer "sound_id", null: false
    t.integer "theme_id", null: false
    t.index ["sound_id", "theme_id"], name: "index_sounds_themes_on_sound_id_and_theme_id", using: :btree
  end

  create_table "stress2_surveys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "result"
    t.text     "recommendation"
    t.integer  "score"
    t.integer  "p1"
    t.integer  "p2"
    t.integer  "p3"
    t.integer  "p4"
    t.integer  "p5"
    t.integer  "p6"
    t.integer  "p7"
    t.integer  "p8"
    t.integer  "p9"
    t.integer  "p10"
    t.integer  "p11"
    t.integer  "p12"
    t.integer  "p13"
    t.integer  "p14"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "stress_surveys", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "p1"
    t.integer  "p2"
    t.integer  "p3"
    t.integer  "p4"
    t.integer  "p5"
    t.integer  "p6"
    t.integer  "p7"
    t.integer  "score"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "result"
    t.text     "recommendations"
  end

  create_table "themes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "themes_videos", id: false, force: :cascade do |t|
    t.integer "video_id", null: false
    t.integer "theme_id", null: false
    t.index ["video_id", "theme_id"], name: "index_themes_videos_on_video_id_and_theme_id", using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_programs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.integer  "curr_sound"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "admin",                  default: false
    t.string   "academic_type"
    t.string   "sex"
    t.integer  "age"
    t.string   "school"
    t.integer  "year"
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "added_by"
    t.integer  "duration"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "video_file_file_name"
    t.string   "video_file_content_type"
    t.integer  "video_file_file_size"
    t.datetime "video_file_updated_at"
    t.string   "audio_file_file_name"
    t.string   "audio_file_content_type"
    t.integer  "audio_file_file_size"
    t.datetime "audio_file_updated_at"
    t.string   "image_file_file_name"
    t.string   "image_file_content_type"
    t.integer  "image_file_file_size"
    t.datetime "image_file_updated_at"
  end

end
