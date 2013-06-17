# -*- encoding : utf-8 -*-
class ArtistDetailsSingleTableInheritance < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.remove :artist_detail_id
      t.string :type
      t.text :bio,          :null => false, :default => ''
      t.text :bounty_rules, :null => false, :default => ''
      t.boolean :approved,  :null => false, :default => false
    end

    rename_column :candidacies, :artist_detail_id, :artist_id

    drop_table :artist_details
  end

  def down
    create_table :artist_details do |t|
      t.text :bio,          :null => false, :default => ''
      t.text :bountyRules,  :null => false, :default => ''
      t.boolean :approved,  :null => false, :default => false
    end

    rename_column :candidacies, :artist_id, :artist_detail_id

    change_table :users do |t|
      t.remove :type, :bio, :bounty_rules, :approved
      t.references :artist_details
    end
  end
end
