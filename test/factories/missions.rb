# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mission do
    title       Faker::Lorem.words(3).join(" ")
    description Faker::Lorem.paragraph
    source_code {File.new(Rails.root.join("test", "fixtures", "empty_project.xml"))}
  end
end
