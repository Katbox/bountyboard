# -*- encoding : utf-8 -*-
class AddAcceptDateToCandidacy < ActiveRecord::Migration
  def up
    add_column :candidacies, :accepted_at, :datetime
  end

  def down
    remove_column :candidacies, :accepted_at
  end
end
