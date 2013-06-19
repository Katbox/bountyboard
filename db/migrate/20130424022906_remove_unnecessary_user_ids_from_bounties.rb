# -*- encoding : utf-8 -*-
class RemoveUnnecessaryUserIdsFromBounties < ActiveRecord::Migration
  def change
    add_column :candidacies, :is_acceptor, :boolean, :default => false, :null => false
	rename_column :bounties, :private, :is_private
    remove_column :bounties, :accept_id
    remove_column :bounties, :complete_id
  end
end
