# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :file_mission do
    file {File.new(Rails.root.join("test", "fixtures", "image_test.gif"))}

    mission
  end
end
