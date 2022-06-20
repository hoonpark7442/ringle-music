class Playlist < ApplicationRecord
  belongs_to :playlistable, polymorphic: true

  has_many :playlist_songs, dependent: :delete_all
  has_many :song_lists, through: :playlist_songs, source: :song

  validates :name, :playlistable_id, :playlistable_type, presence: true
  validates :playlistable_id, uniqueness: { scope: :playlistable_type }
end
