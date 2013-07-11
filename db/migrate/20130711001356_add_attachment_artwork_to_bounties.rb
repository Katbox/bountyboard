class AddAttachmentArtworkToBounties < ActiveRecord::Migration
  def self.up
    change_table :bounties do |t|
      t.attachment :artwork
    end
  end

  def self.down
    drop_attached_file :bounties, :artwork
  end
end
