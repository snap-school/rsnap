# == Schema Information
#
# Table name: chapters
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  description       :text
#  small_description :text
#  youtube           :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  teacher_id        :integer
#  teacher_type      :string(255)
#
# Indexes
#
#  index_chapters_on_teacher_id_and_teacher_type  (teacher_id, teacher_type)
#

# Read about factories at https://github.com/thoughtbot/factory_girl
# include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :chapter do
    title               Faker::Lorem.words(3).join(" ")
    description         Faker::Lorem.paragraph
    small_description   Faker::Lorem.paragraph
  end
end
