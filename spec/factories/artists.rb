FactoryBot.define do
  factory :artist do
    name { Faker::Kpop.girl_groups }
  end
end
