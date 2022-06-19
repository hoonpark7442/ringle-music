FactoryBot.define do
  factory :song do
    title { Faker::Book.title }
    favorite_counts { 100 }

    association :artist, :album
  end
end
