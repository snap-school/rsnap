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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :file_mission do
    file {File.new(Rails.root.join("test", "fixtures", "image_test.gif"))}

    mission
  end
end
