# == Schema Information
#
# Table name: solved_missions
#
#  id         :integer          not null, primary key
#  mission_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class SolvedMission < ActiveRecord::Base
  include Authority::Abilities

  belongs_to :mission
  belongs_to :user

  validates :user_id, :mission_id, :presence=>true
  validates_uniqueness_of :mission_id, :scope=>:user_id

  scope :for_mission, ->(mission){where(:mission_id=>mission)}
  scope :for_user, ->(user){where(:user_id=>user)}
  scope :order_by_missions, ->{includes(:mission).order("missions.mission_order ASC")}

  def self.for_mission_for_user(mission, user)
    SolvedMission.for_mission(mission).for_user(user).first
  end
end
