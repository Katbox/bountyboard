class RenameBountyIsAcceptor < ActiveRecord::Migration
  def change
    rename_column :candidacies, :is_acceptor, :acceptor
  end
end
