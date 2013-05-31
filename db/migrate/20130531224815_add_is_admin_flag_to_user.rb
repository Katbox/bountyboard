class AddIsAdminFlagToUser < ActiveRecord::Migration
  def up
    add_column :users, :admin, :boolean
  end

  def down
    add_column :users, :admin, :boolean
  end
end
