class AddTagLineToBounty < ActiveRecord::Migration
  def up
    add_column :bounties, :tag_line, :string
  end

  def down
    remove_column :bounties, :tag_line
  end
end