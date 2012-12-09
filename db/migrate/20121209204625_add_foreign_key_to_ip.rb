class AddForeignKeyToIp < ActiveRecord::Migration
  def up
  	add_column :ips, :artist_id, :integer
  end

  def down
  	remove_column :ips, :artist_id, :integer
  end
end
