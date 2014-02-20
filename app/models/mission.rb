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

  validates_attachment :source_code, :presence => true
  validates :title, :description, :presence=>true

  include RankedModel
  ranks :mission_order
  default_scope rank(:mission_order)

  def position(scope=:all)
    Mission.send(scope).find_index(self)
  end

  def description_with_dropbox
    puts "\n\n\n\n\n\n\n\n\n\n\ndescription_with_dropbox\n"
    description.gsub(/"http[s]?:\/\/dl\.dropboxusercontent\.com\/1\/view\/\w*\/Applications.*\/(\w+\.\w*)"/) do
      "'#{dropbox_url(Regexp.last_match[1])}'"
   end
  end

  private
  def dropbox_url(file_name)
    FileMission.where(:file_file_name=>file_name).first.file.url
  end
end
