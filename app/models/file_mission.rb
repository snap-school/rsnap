class FileMission < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'MissionAuthorizer'

  belongs_to :mission
  delegate :title, :to=>:mission, :prefix=>true

  has_attached_file :file, :storage => :dropbox,
                    :dropbox_credentials => DROPBOX_CREDENTIALS
end
