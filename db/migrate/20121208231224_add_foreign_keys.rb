class AddForeignKeys < ActiveRecord::Migration
  def up
  	add_column :bounties, :user_id, :integer
  	add_column :bounties, :status_id, :integer
  end

  def down
  	remove_column :bounties, :user_id, :integer
  	remove_column :bounties, :status_id, :integer
  end
end
