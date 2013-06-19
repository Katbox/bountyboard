# -*- encoding : utf-8 -*-
class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
	  add_column :users, :rememberToken, :string
	  add_index :users, :rememberToken
  end
end
