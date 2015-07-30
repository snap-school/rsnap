# == Schema Information
#
# Table name: file_missions
#
#  id                :integer          not null, primary key
#  mission_id        :integer
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_file_missions_on_mission_id  (mission_id)
#

class FileMission < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'MissionAuthorizer'

  belongs_to :mission
  delegate :title, to:  :mission, prefix:  true

  has_attached_file :file
  validates_attachment :file, presence:  true, content_type:  { content_type:  ["image/jpg", "image/jpeg", "image/gif", "image/png"] }
end
