class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
    	t.string :name
    	t.string :desc
    	t.string :rules
      	t.timestamps
    end
  end
end
