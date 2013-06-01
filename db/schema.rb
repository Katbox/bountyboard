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

ActiveRecord::Schema.define(:version => 20130601041202) do

  create_table "bounties", :force => true do |t|
    t.string   "name",                              :null => false
    t.text     "desc",                              :null => false
    t.integer  "price_cents",    :default => 0,     :null => false
    t.string   "price_currency", :default => "USD", :null => false
    t.boolean  "adult_only",     :default => false, :null => false
    t.boolean  "is_private",     :default => false, :null => false
    t.string   "url"
    t.integer  "user_id",                           :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "candidacies", :force => true do |t|
    t.integer  "bounty_id",                      :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "artist_id",                      :null => false
    t.boolean  "acceptor",    :default => false, :null => false
    t.datetime "accepted_at"
  end

  create_table "moods", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "personalities", :force => true do |t|
    t.integer  "mood_id",    :null => false
    t.integer  "bounty_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",                            :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "rememberToken"
    t.string   "type"
    t.text     "bio",           :default => "",    :null => false
    t.text     "bounty_rules",  :default => "",    :null => false
    t.boolean  "approved",      :default => false, :null => false
    t.boolean  "admin",         :default => false, :null => false
  end

  add_index "users", ["rememberToken"], :name => "index_users_on_rememberToken"

  create_table "votes", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "bounty_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
