class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :album

  validates :artist_id, :album_id, presence: true
end
