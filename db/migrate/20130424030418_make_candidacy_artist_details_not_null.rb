# -*- encoding : utf-8 -*-
class MakeCandidacyArtistDetailsNotNull < ActiveRecord::Migration
  def change
    change_column :candidacies, :artist_detail_id, :integer, :null => false
  end
end
