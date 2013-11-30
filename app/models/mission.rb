class Mission < ActiveRecord::Base
  has_many :program

  has_attached_file :source_code, :storage => :dropbox,
                    :dropbox_credentials => DROPBOX_CREDENTIALS

  validates_attachment :source_code,  :presence     => true
end
