class AddAttachmentPreviewToBounties < ActiveRecord::Migration
  def self.up
    change_table :bounties do |t|
      t.attachment :preview
    end
  end

  def self.down
    drop_attached_file :bounties, :preview
  end
end
