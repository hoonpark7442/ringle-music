FactoryBot.define do
  sequence(:email) { |n| "test#{n}@test.com" }
  factory :user do
    email { generate :email }
    name { Faker::Name.name }
    password { "123123" }
  end
end
