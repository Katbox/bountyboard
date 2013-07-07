class AddCompleteByDate < ActiveRecord::Migration
  def up
    add_column :bounties, :complete_by, :datetime
  end

  def down
    remove_column :bounties, :complete_by
  end
end
