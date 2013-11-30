class Program < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user

  has_attached_file :source_code, :storage => :dropbox,
                    :dropbox_credentials => DROPBOX_CREDENTIALS

  validate :user_id, :mission_id, :presence=>true

  scope :for_mission, lambda{|mission| where(:mission_id=>mission)}
  scope :for_user, lambda{|user| where(:user_id=>user)}

  def self.for_mission_for_user(mission, user)
    Program.for_mission(mission).for_user(user).first
  end
end
