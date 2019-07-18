class CreateHeros < ActiveRecord::Migration[5.2]
  def change
    create_table :heros do |t|

      t.column "name", :string
      t.string "superpower", :limit => 50
      t.string "company", :null => false
      t.string "alignment", :null => false
      t.timestamps
    end
  end
end
