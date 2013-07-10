class AddUniqueKeys < ActiveRecord::Migration
  def up
    remove_index :users, :rememberToken

    add_index :bounties, :name, :unique => true
    add_index :candidacies, [:bounty_id, :artist_id], :unique => true
    add_index :favorites, [:bounty_id, :user_id], :unique => true
    add_index :moods, :name, :unique => true
    add_index :personalities, [:bounty_id, :mood_id], :unique => true
    add_index :users, :name, :unique => true
    add_index :users, :email, :unique => true
    add_index :users, :rememberToken, :unique => true
    add_index :votes, [:bounty_id, :user_id], :unique => true
  end

  def down
    remove_index :bounties, :name
    remove_index :candidacies, :bounty_id
    remove_index :favorites, :bounty_id
    remove_index :moods, :name
    remove_index :personalities, [:bounty_id, :mood_id]
    remove_index :users, :name
    remove_index :users, :email
    remove_index :users, :rememberToken
    remove_index :votes, [:bounty_id, :user_id]

    add_index :users, :rememberToken, :name => "index_users_on_rememberToken"
  end
end
