class CreateTaxonomies < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
    	t.string :type

    	t.timestamps
    end
  end
end
