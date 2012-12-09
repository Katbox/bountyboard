class AddUrlToBounty < ActiveRecord::Migration
  def up
  	add_column :bounties, :url, :string
  end

  def down
  	remove_column :bounties, :url, :string
  end
end
