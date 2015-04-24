class CreateSolvedMissions < ActiveRecord::Migration
  def change
    create_table :solved_missions do |t|
      t.integer :mission_id
      t.integer :user_id
      t.timestamps
    end
  end
end
