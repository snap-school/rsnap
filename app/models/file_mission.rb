class FileMission < ActiveRecord::Base
  belongs_to :mission

  has_attached_file :file
end
