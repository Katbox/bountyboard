# -*- encoding : utf-8 -*-
class RenameIsPrivateToPrivate < ActiveRecord::Migration
  def change
    rename_column :bounties, :is_private, :private
  end
end
