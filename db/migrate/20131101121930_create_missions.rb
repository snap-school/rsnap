class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :title
      t.text :description
      t.attachment :source_code

      t.timestamps
    end
  end
end
