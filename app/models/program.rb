class Program < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'ProgramAuthorizer'

  belongs_to :mission
  delegate :title, :to=>:mission, :prefix=>true
  belongs_to :user
  delegate :name, :to=>:user, :prefix=>true

  has_attached_file :source_code, :storage => :dropbox,
                    :dropbox_credentials => DROPBOX_CREDENTIALS

  validates :user_id, :mission_id, :presence=>true

  #validate :uniqueness_on_user_and_mission

  scope :for_mission, lambda{|mission| where(:mission_id=>mission)}
  scope :for_user, lambda{|user| where(:user_id=>user)}

  def self.for_mission_for_user(mission, user)
    Program.for_mission(mission).for_user(user).first
  end

  def uniqueness_on_user_and_mission
    if Program.for_mission(mission).for_user(user).count >= 1
      errors.add(:mission, "Il y a déjà un programme pour cette mission au nom de l'utilisateur #{user.name}")
    end
  end
end
