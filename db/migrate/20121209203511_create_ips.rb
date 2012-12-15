class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
    	t.string :name, :null => false
    	t.text :desc, :null => false
    	t.text :rules, :null => false
    	t.integer :user_id, :null => false
      	t.timestamps
    end
  end
end
