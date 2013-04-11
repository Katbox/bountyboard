class CreateArtistDetails < ActiveRecord::Migration
  def up
    create_table :artist_details do |t|
      t.text :bio,         :null => false
      t.text :bountyRules, :null => false
      t.boolean :approved, :null => false, :default => false
    end

	change_table :users do |t|
	  t.references :artist_detail
	  t.remove :isArtist
	end

	change_table :candidacies do |t|
	  t.references :artist_detail
	  t.remove :user_id
	end
  end

  def down
	change_table :users do |t|
	  t.remove :artist_detail_id
	  t.boolean :isArtist
	end

	change_table :candidacies do |t|
	  t.remove :artist_detail_id
	  t.references :user
	end

	drop_table :artist_details
  end
end
