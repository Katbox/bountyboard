class AddArtistDetails < ActiveRecord::Migration
  def up
  	add_column :artists, :desc, :text
  	add_column :artists, :rules, :text
  end

  def down
  	remove_column :artists, :desc, :text
  	remove_column :artists, :rules, :text
  end
end
