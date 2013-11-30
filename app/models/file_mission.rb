class FileMission < ActiveRecord::Base
  belongs_to :mission, :dependent=>:destroy

  has_attached_file :file, :storage => :dropbox,
                    :dropbox_credentials => DROPBOX_CREDENTIALS
end
