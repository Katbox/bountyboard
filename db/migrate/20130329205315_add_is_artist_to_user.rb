# -*- encoding : utf-8 -*-
class AddIsArtistToUser < ActiveRecord::Migration
  def change
    add_column :users, :isArtist, :boolean
  end
end
