# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program do
    source_code {File.new(Rails.root.join("test", "fixtures", "empty_project.xml"))}

    user
    mission
  end
end
