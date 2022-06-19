class Group < ApplicationRecord
	has_many :group_memberships,  dependent: :delete_all
  has_many :users, through: :group_memberships
  has_many :playlists, as: :playlistable, dependent: :delete_all

	validates :name, presence: true
end
