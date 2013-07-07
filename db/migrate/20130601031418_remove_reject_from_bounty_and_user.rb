class RemoveRejectFromBountyAndUser < ActiveRecord::Migration
  def up
    remove_column :bounties, :reject_id
  end

  def down
    add_column :bounties, :reject_id, :integer
  end
end
