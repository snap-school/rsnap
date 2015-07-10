# == Schema Information
#
# Table name: student_courses
#
#  id         :integer          not null, primary key
#  student_id :integer
#  course_id  :integer
#
# Indexes
#
#  index_student_courses_on_student_id_and_course_id  (student_id,course_id)
#

class StudentCourse < ActiveRecord::Base
  belongs_to :course
  belongs_to :student
end
