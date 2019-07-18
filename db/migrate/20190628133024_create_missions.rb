class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.string "description"
      t.date "date"
      t.string "place"
      t.integer "hero_id"
      t.string "status", :limit => 30, :default => 'in progress'
      t.timestamps
    end
    add_index("missions", "hero_id")
  end
end
