# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  firstname              :string(255)
#  lastname               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  type                   :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class Student < User
  self.inheritance_column = :type

  devise :database_authenticatable, :timeoutable


  has_many :student_courses
  has_many :courses, through: :student_courses

  def teachers
  	t_list = []
  	teacher.all
  	self.courses.find_each do |c|
      t_list.append c.teacher
  	end
  	t_list
  end

  def has_role?(role)
  	return role == "Student" || role == :student
  end
end
