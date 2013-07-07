class MakeTagLineNotNull < ActiveRecord::Migration
  def change
    change_column :bounties, :tag_line, :string, :null => false
  end
end
