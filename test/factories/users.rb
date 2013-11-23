# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname             { Faker::Name.first_name }
    lastname              { Faker::Name.last_name }
    email                 { "#{firstname.downcase}-#{lastname.downcase}@#{Faker::Internet.domain_name}" }
    password              "azertyuiop"
    password_confirmation { password }
  end
end
