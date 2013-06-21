class AddVoteTypeToVote < ActiveRecord::Migration
    def up
    add_column :votes, :vote_type, :boolean, :null => false, :default => false
  end

  def down
    remove_column :votes, :vote_type
  end
end
