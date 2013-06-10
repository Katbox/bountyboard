# -*- encoding : utf-8 -*-
class AddActiveToArtist < ActiveRecord::Migration
  def up
    add_column :users, :active, :boolean
  end

  def down
    remove_column :users, :active
  end
end
