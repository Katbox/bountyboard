class AddTypeToVote < ActiveRecord::Migration
    def up
    add_column :votes, :type, :boolean, :null => false, :default => false
  end

  def down
    remove_column :votes, :type
  end
end
