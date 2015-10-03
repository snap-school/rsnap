class CreateChapterMissionManifests < ActiveRecord::Migration
  def change
    create_table :chapter_mission_manifests do |t|
      t.integer :order
      t.timestamps
    end
  end
end
