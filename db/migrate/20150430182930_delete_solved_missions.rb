class DeleteSolvedMissions < ActiveRecord::Migration
  def change
  	drop_table :solved_missions
  end
end
