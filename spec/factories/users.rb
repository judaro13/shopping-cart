FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name.capitalize }
    last_name  { Faker::Name.last_name.capitalize }
    email      { Faker::Internet.email }
    password   { Faker::Lorem.characters(8) }
    title      'Mr'
  end
end
