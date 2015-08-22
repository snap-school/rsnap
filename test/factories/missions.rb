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
#  small_description        :text
#  youtube                  :string(255)
#  needs_check              :boolean          default(FALSE)
#  teacher_id               :integer
#  teacher_type             :string(255)
#
# Indexes
#
#  index_missions_on_teacher_id_and_teacher_type  (teacher_id,teacher_type)
#

# Read about factories at https://github.com/thoughtbot/factory_girl
# include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :mission do
    title               Faker::Lorem.words(3).join(" ")
    description         Faker::Lorem.paragraph
    small_description   Faker::Lorem.paragraph
    source_code         { fixture_file_upload(Rails.root.join("test", "fixtures", "empty_project.xml"), 'text/xml') }
  end
end
