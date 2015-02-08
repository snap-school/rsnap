class AddChapterAndMissionToManifest < ActiveRecord::Migration
  def change
    add_column :chapter_mission_manifests, :chapter_id, :integer
    add_column :chapter_mission_manifests, :mission_id, :integer
  end
end
