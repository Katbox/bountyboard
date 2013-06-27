class RemoveScoreFromBounties < ActiveRecord::Migration
  def up
    remove_column :bounties, :score
      end

  def down
    add_column :bounties, :score, :decimal
  end
end
