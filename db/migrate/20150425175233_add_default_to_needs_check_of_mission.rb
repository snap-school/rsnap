class AddDefaultToNeedsCheckOfMission < ActiveRecord::Migration
  def change
  	change_column :missions, :needs_check, :boolean, :default=>false
  end
end
