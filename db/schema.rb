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

ActiveRecord::Schema.define(:version => 20121209205442) do

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "desc"
    t.text     "rules"
  end

  create_table "bounties", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.string   "rating"
    t.integer  "vote"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "user_id"
    t.integer  "status_id"
    t.string   "url"
  end

  create_table "completions", :force => true do |t|
    t.integer  "bounty_id"
    t.integer  "artist_id"
    t.integer  "taxonomy_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ips", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "rules"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "artist_id"
  end

  create_table "statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taxonomies", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
