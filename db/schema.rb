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

ActiveRecord::Schema.define(:version => 20130710192322) do

  create_table "bounties", :force => true do |t|
    t.string   "name",                              :null => false
    t.text     "desc",                              :null => false
    t.integer  "price_cents",    :default => 0,     :null => false
    t.string   "price_currency", :default => "USD", :null => false
    t.boolean  "adult_only",     :default => false, :null => false
    t.boolean  "private",        :default => false, :null => false
    t.string   "url"
    t.integer  "user_id",                           :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.datetime "completed_at"
    t.datetime "complete_by"
    t.string   "tag_line",                          :null => false
  end

  add_index "bounties", ["name"], :name => "index_bounties_on_name", :unique => true

  create_table "candidacies", :force => true do |t|
    t.integer  "bounty_id",   :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "artist_id",   :null => false
    t.datetime "accepted_at"
  end

  add_index "candidacies", ["bounty_id", "artist_id"], :name => "index_candidacies_on_bounty_id_and_artist_id", :unique => true

  create_table "favorites", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "bounty_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorites", ["bounty_id", "user_id"], :name => "index_favorites_on_bounty_id_and_user_id", :unique => true

  create_table "moods", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "moods", ["name"], :name => "index_moods_on_name", :unique => true

  create_table "personalities", :force => true do |t|
    t.integer  "mood_id",    :null => false
    t.integer  "bounty_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "personalities", ["bounty_id", "mood_id"], :name => "index_personalities_on_bounty_id_and_mood_id", :unique => true

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
    t.boolean  "active"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["rememberToken"], :name => "index_users_on_rememberToken", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "bounty_id",                     :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "vote_type",  :default => false, :null => false
  end

  add_index "votes", ["bounty_id", "user_id"], :name => "index_votes_on_bounty_id_and_user_id", :unique => true

  add_foreign_key "bounties", "users", :name => "bounties_user_id_fk"

  add_foreign_key "candidacies", "bounties", :name => "candidacies_bounty_id_fk"
  add_foreign_key "candidacies", "users", :name => "candidacies_artist_id_fk", :column => "artist_id"

  add_foreign_key "favorites", "bounties", :name => "favorites_bounty_id_fk"
  add_foreign_key "favorites", "users", :name => "favorites_user_id_fk"

  add_foreign_key "personalities", "bounties", :name => "personalities_bounty_id_fk"
  add_foreign_key "personalities", "moods", :name => "personalities_mood_id_fk"

  add_foreign_key "votes", "bounties", :name => "votes_bounty_id_fk"
  add_foreign_key "votes", "users", :name => "votes_user_id_fk"

end
