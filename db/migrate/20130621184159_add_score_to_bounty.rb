# -*- encoding : utf-8 -*-
class AddScoreToBounty < ActiveRecord::Migration
  def up
    add_column :bounties, :score, :decimal, :default => 0.0
  end

  def down
    remove_column :bounties, :score
  end
end
