class Song < ApplicationRecord
  delegate :name, to: :artist, prefix: true
  delegate :title, to: :album, prefix: true

  belongs_to :artist
  belongs_to :album

  validates :artist_id, :album_id, presence: true

  before_save :set_caches

  private

  def set_caches
    return unless artist || album

    self.cached_artist_name = artist_name
    self.cached_album_name = album_title
  end
end
