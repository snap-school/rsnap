class AddMissingIndexes < ActiveRecord::Migration
  def change
  	add_index :chapter_mission_manifests, :mission_id
  	add_index :chapter_mission_manifests, :chapter_id
  	add_index :course_chapter_manifests, :course_id
  	add_index :course_chapter_manifests, :chapter_id
  	add_index :chapters, [:teacher_id, :teacher_type]
  	add_index :missions, [:teacher_id, :teacher_type]
  	add_index :courses, [:teacher_id, :teacher_type]
  end
end
