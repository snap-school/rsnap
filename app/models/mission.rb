class Mission < ActiveRecord::Base
  has_attached_file :source_code, :storage => :dropbox,
                    :dropbox_credentials => DROPBOX_CREDENTIALS

  validates_attachment :source_code,  :presence     => true,
                                      :content_type => { :content_type => "text/xml" }
end
