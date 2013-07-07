class RemoveAcceptorFromCandidacy < ActiveRecord::Migration
  def up
    remove_column :candidacies, :acceptor
      end

  def down
    add_column :candidacies, :acceptor, :boolean
  end
end
