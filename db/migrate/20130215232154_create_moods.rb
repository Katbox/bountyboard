class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
        t.string :name, :null => false
        t.timestamps
    end
  end
end
