class CreateBounties < ActiveRecord::Migration
  def change
    create_table :bounties do |t|
    	t.string :name, :null => false
    	t.text :desc, :null => false
    	t.decimal :price, :precision => 8, :scale => 2, :null => false
    	t.boolean :rating, :null => false, :default => false
      t.boolean :private, :null => false, :default => false
      t.string  :url
      t.integer :primary_mood_id, :null => false
      t.integer :secondary_mood_id
      t.integer :user_id, :null => false      #OWNERSHIP
      t.integer :accept_id                    #ACCEPTANCE
      t.integer :reject_id                    #REJECTION
      t.integer :complete_id                  #COMPLETION
      t.timestamps
    end
  end
end
