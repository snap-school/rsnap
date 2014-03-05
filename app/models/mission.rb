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
  has_many :file_missions, :dependent=>:destroy

  has_attached_file :source_code

  validates_attachment :source_code, :presence => true, :content_type => { :content_type => ["text/xml"] }
  validates :title, :description, :small_description, :presence=>true

  include RankedModel
  ranks :mission_order
  default_scope {rank(:mission_order)}

  def position(scope=:all)
    Mission.send(scope).find_index(self)
  end
end
