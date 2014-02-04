# == Schema Information
#
# Table name: missions
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  description              :text
#  source_code_file_name    :string(255)
#  source_code_content_type :string(255)
#  source_code_file_size    :integer
#  source_code_updated_at   :datetime
#  created_at               :datetime
#  updated_at               :datetime
#

class Mission < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'MissionAuthorizer'

  has_many :program, :dependent=>:destroy

  has_attached_file :source_code, :storage => :dropbox,
                    :dropbox_credentials => DROPBOX_CREDENTIALS

  validates_attachment :source_code,  :presence     => true
  validates :title, :description, :presence=>true
end
