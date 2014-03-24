class AddYoutubeToMission < ActiveRecord::Migration
  def change
    add_column :missions, :youtube, :string
  end
end
