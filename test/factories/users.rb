# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname             { Faker::Name.first_name }
    lastname              { Faker::Name.last_name }
    email                 { "#{firstname.downcase}-#{lastname.downcase}@#{Faker::Internet.domain_name}" }
    password              "azertyuiop"
    password_confirmation { password }

    factory :admin do
      after(:create) do |user|
        user.add_role(:admin)
      end
    end
  end
end
