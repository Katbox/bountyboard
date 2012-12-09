class PriceAdjustment < ActiveRecord::Migration
  def up
  	change_column :bounties, :price, :decimal, :precision => 8, :scale => 2
  end

  def down
  	change_column :bounties, :price, :decimal
  end
end
