class AddSmallDescriptionToMission < ActiveRecord::Migration
  def change
    add_column :missions, :small_description, :text
  end
end
