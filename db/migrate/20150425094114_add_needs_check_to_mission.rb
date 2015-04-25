class AddNeedsCheckToMission < ActiveRecord::Migration
  def change
    add_column :missions, :needs_check, :boolean
  end
end
