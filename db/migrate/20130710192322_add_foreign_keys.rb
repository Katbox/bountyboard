class AddForeignKeys < ActiveRecord::Migration
  def up
    add_foreign_key :bounties,      :users
    add_foreign_key :candidacies,   :bounties
    add_foreign_key :candidacies,   :users, column: 'artist_id'
    add_foreign_key :favorites,     :users
    add_foreign_key :favorites,     :bounties
    add_foreign_key :personalities, :moods
    add_foreign_key :personalities, :bounties
    add_foreign_key :votes,         :bounties
    add_foreign_key :votes,         :users
  end

  def down
    remove_foreign_key :bounties,      :users
    remove_foreign_key :candidacies,   :bounties
    remove_foreign_key :candidacies,   column: 'artist_id'
    remove_foreign_key :favorites,     :users
    remove_foreign_key :favorites,     :bounties
    remove_foreign_key :personalities, :moods
    remove_foreign_key :personalities, :bounties
    remove_foreign_key :votes,         :bounties
    remove_foreign_key :votes,         :users
  end
end
