# -*- encoding : utf-8 -*-
class RemoveFilterTemplates < ActiveRecord::Migration
  def up
    drop_table :filter_templates
  end

  def down
    create_table :filter_templates do |t|
      t.string :name
      t.string :sql

      t.timestamps
    end
    add_index :filter_templates, :name
  end
end
