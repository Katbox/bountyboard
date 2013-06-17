# -*- encoding : utf-8 -*-
class RenameBountyRating < ActiveRecord::Migration
  def change
    rename_column :bounties, :rating, :adult_only
  end
end
