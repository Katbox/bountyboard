class CreateBounties < ActiveRecord::Migration
  def change
    create_table :bounties do |t|
    	t.string :name
    	t.string :desc
    	t.decimal :price
    	t.string :rating
    	t.integer :vote
      	t.timestamps
    end
  end
end
