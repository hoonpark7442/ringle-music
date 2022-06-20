FactoryBot.define do
  factory :playlist_song do
    association :playlist, :song
  end
end
