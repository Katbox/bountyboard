# -*- encoding : utf-8 -*-
class CreatePersonalities < ActiveRecord::Migration
  def change
    create_table :personalities do |t|
        t.integer :mood_id, :null => false
        t.integer :bounty_id, :null => false
        t.timestamps
    end
  end
end
