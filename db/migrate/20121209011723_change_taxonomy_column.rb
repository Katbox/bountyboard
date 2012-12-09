class ChangeTaxonomyColumn < ActiveRecord::Migration
  def up
  	remove_column :taxonomies, :type, :string
  	add_column :taxonomies, :name, :string
  end

  def down
  	add_column :taxonomies, :type, :string
  	remove_column :taxonomies, :name, :string
  end
end
