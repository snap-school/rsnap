# == Schema Information
#
# Table name: projects
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  user_id                  :integer
#  source_code_file_name    :string(255)
#  source_code_content_type :string(255)
#  source_code_file_size    :integer
#  source_code_updated_at   :datetime
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#

class Project < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'ProjectAuthorizer'

  belongs_to :user

  delegate :name, :to=>:user, :prefix=>true

  has_attached_file :source_code
  validates_attachment :source_code, :presence => true, :content_type => { :content_type => /text/ }

  validates :user_id, :presence=>true

  scope :for_user, lambda{|user| where(:user_id=>user)}
end
