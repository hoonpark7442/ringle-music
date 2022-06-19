FactoryBot.define do
  factory :song do
    artist { nil }
    album { nil }
    title { "MyString" }
    favorite_counts { 1 }
    cached_artist_name { "MyString" }
    cached_album_name { "MyString" }
  end
end
