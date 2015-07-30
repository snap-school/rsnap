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
#  state                    :integer          default(0)
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
  belongs_to :user

  delegate :title, :to=>:mission, :prefix=>true
  delegate :name, :to=>:user, :prefix=>true
  delegate :needs_check, :to=>:mission, :prefix=>true

  has_attached_file :source_code

  validates_attachment :source_code, :presence=>true, :content_type=>{:content_type=>/text/}
  validates :user_id, :mission_id, :presence=>true
  validates_uniqueness_of :mission_id, :scope=>:user_id

  scope :for_mission, ->(mission){where(:mission_id=>mission)}
  scope :for_user, ->(user){where(:user_id=>user)}

  State_to_be_done = 0
  State_to_be_corrected = 1
  State_corrected = 2
  State_solved = 3

  def has_to_be_done?
    return self.state == State_to_be_done
  end

  def is_in_correction?
    return self.state == State_to_be_corrected
  end

  def is_corrected?
    return self.state == State_corrected
  end

  def solved_mission?
    return self.state == State_solved
  end
  
  def self.for_mission_for_user(mission, user)
    Program.for_mission(mission).for_user(user).first
  end

  def self.visible_for(user)
    user.try(:has_role?,:admin) ? Program.all : (user.try(:has_role?, :teacher) ? Program.where(programs_table[:mission_id].in user.missions.map(&:id)) : Program.for_user(user))
  end
end
