class CreateBounties < ActiveRecord::Migration
  def change
    create_table :bounties do |t|
    	t.string :name, :null => false
    	t.text :desc, :null => false
    	t.money :price, :null => false
    	t.boolean :rating, :null => false, :default => false
      t.boolean :private, :null => false, :default => false
      t.string  :url
      t.integer :user_id, :null => false      #OWNERSHIP
      t.integer :accept_id                    #ACCEPTANCE
      t.integer :reject_id                    #REJECTION
      t.integer :complete_id                  #COMPLETION
      t.timestamps
    end
  end
end
