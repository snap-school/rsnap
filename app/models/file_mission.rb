class FileMission < ActiveRecord::Base
  belongs_to :mission

  has_attached_file :file, :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
end
