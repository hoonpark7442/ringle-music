FactoryBot.define do
  factory :album do
    title { Faker::Music.album }
    
    association :artist
  end
end
