# == Schema Information
#
# Table name: teachers
#
#  id      :integer          not null, primary key
#  user_id :integer
#
# Indexes
#
#  index_teachers_on_user_id  (user_id) UNIQUE
#

class Teacher < ActiveRecord::Base
  belongs_to :user

  has_many :courses
  has_many :chapters
  has_many :missions

  def method_missing(method, *args)
    return user.send(method, *args) if user.respond_to?(method)
    super
  end
end
