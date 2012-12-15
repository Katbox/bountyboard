class CreateCandidacies < ActiveRecord::Migration
  def change
    create_table :candidacies do |t|
      t.integer :user_id, :null => false
      t.integer :bounty_id, :null => false
      t.timestamps
    end
  end
end
