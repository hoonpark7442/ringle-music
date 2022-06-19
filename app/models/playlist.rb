class Playlist < ApplicationRecord
  belongs_to :playlistable, polymorphic: true

  validates :name, :playlistable_id, :playlistable_type, presence: true
end
