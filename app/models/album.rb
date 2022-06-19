class Album < ApplicationRecord
  has_many :songs, dependent: :delete_all
  belongs_to :artist

  validates :title, :artist_id, presence: true
end
