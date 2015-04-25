class RemoveMissionOrderFromMissions < ActiveRecord::Migration
  def change
  	remove_column :missions, :mission_order
  end
end
