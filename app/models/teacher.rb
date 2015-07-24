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

class Teacher < User
  self.inheritance_column = :type
  
  devise :database_authenticatable, :timeoutable

  has_many :courses, as: :teacher
  has_many :chapters, as: :teacher
  has_many :missions, as: :teacher

  def students
    Student.joins("INNER JOIN student_courses ON student_courses.student_id = users.id").where(Arel::Table.new(:student_courses)[:course_id].in self.courses.map(&:id)).distinct
  end

  def is_teacher_for?(user)
    students.where(:id=>user.id).present?
  end

  def has_role?(role)
    return role == "Teacher" || role == :teacher
  end

  def self.model_name
    User.model_name
  end
end
