# == Schema Information
#
# Table name: course_chapter_manifests
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  chapter_id :integer
#  order      :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_course_chapter_manifests_on_chapter_id  (chapter_id)
#  index_course_chapter_manifests_on_course_id   (course_id)
#

class CourseChapterManifest < ActiveRecord::Base
  belongs_to :course
  belongs_to :chapter

  def before_destroy
    self.course.remove_chapter(self.mission)
  end
end
