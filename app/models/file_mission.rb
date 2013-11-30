class FileMission < ActiveRecord::Base
  belongs_to :mission
  delegate :title, :to=>:mission, :prefix=>true

  has_attached_file :file, :storage => :dropbox,
                    :dropbox_credentials => DROPBOX_CREDENTIALS
end
