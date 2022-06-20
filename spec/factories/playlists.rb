FactoryBot.define do
  factory :playlist do
    name { "MyString" }
    association :playlistable
  end
end
