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

class CourseChapterManifest < ActiveRecord::Base
  belongs_to :course
  belongs_to :chapter
end
