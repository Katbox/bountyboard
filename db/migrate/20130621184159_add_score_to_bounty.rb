class AddScoreToBounty < ActiveRecord::Migration
  def up
    add_column :bounties, :score, :decimal
  end

  def down
    remove_column :bounties, :score
  end
end
