class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
    	t.integer :bounty_id
    	t.integer :artist_id
    	t.integer :taxonomy_id
      	t.timestamps
    end
  end
end
