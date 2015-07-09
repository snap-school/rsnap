# == Schema Information
#
# Table name: students
#
#  id      :integer          not null, primary key
#  user_id :integer
#
# Indexes
#
#  index_students_on_user_id  (user_id) UNIQUE
#

class Student < ActiveRecord::Base
  belongs_to :user

  has_and_belongs_to_many :courses, :join_table => :student_courses

  def method_missing(method, *args)
    return user.send(method, *args) if user.respond_to?(method)
    super
  end
end
