class CreateFilterTemplates < ActiveRecord::Migration
  def change
    create_table :filter_templates do |t|
      t.string :name
      t.string :sql

      t.timestamps
    end
    add_index :filter_templates, :name
  end
end
