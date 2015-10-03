class CreateCourseChapterManifest < ActiveRecord::Migration
  def change
    create_table :course_chapter_manifests do |t|
      t.integer :course_id
      t.integer :chapter_id
      t.integer :order
      t.timestamps
    end
  end
end
