# == Schema Information
#
# Table name: programs
#
#  id                       :integer          not null, primary key
#  source_code_file_name    :string(255)
#  source_code_content_type :string(255)
#  source_code_file_size    :integer
#  source_code_updated_at   :datetime
#  created_at               :datetime
#  updated_at               :datetime
#  user_id                  :integer
#  mission_id               :integer
#
# Indexes
#
#  index_programs_on_mission_id  (mission_id)
#  index_programs_on_user_id     (user_id)
#

class Program < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'ProgramAuthorizer'

  belongs_to :mission
  delegate :title, :to=>:mission, :prefix=>true
  belongs_to :user
  delegate :name, :to=>:user, :prefix=>true

  has_attached_file :source_code

  validates :user_id, :mission_id, :presence=>true

  validates_uniqueness_of :mission_id, :scope=>:user_id

  scope :for_mission, lambda{|mission| where(:mission_id=>mission)}
  scope :for_user, lambda{|user| where(:user_id=>user)}

  def self.for_mission_for_user(mission, user)
    Program.for_mission(mission).for_user(user).first
  end
end
