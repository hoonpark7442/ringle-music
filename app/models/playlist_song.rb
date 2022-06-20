class PlaylistSong < ApplicationRecord
  belongs_to :playlist
  belongs_to :song

  validates :playlist_id, :song_id, presence: true
end
