class ChangeBountyCompleteByToDate < ActiveRecord::Migration
  def up
    change_column :bounties, :complete_by, :date
  end

  def down
    change_column :bounties, :complete_by, :datetime
  end
end
