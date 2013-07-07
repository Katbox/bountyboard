class AddCompleteDateToBounty < ActiveRecord::Migration
  def up
    add_column :bounties, :completed_at, :datetime
  end

  def down
    remove_column :bounties, :completed_at
  end
end
