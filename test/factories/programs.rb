# == Schema Information
#
# Table name: programs
#
#  id                       :integer          not null, primary key
#  source_code_file_name    :string(255)
#  source_code_content_type :string(255)
#  source_code_file_size    :integer
#  source_code_updated_at   :datetime
#  created_at               :datetime
#  updated_at               :datetime
#  user_id                  :integer
#  mission_id               :integer
#
# Indexes
#
#  index_programs_on_mission_id  (mission_id)
#  index_programs_on_user_id     (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program do
    source_code{fixture_file_upload(Rails.root.join("test", "fixtures", "empty_project.xml"), 'text/xml') }
    user
    mission
  end
end
