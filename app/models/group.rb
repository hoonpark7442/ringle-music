class Group < ApplicationRecord
	has_many :group_memberships,  dependent: :delete_all
  has_many :users, through: :group_memberships
  has_one :playlist, as: :playlistable, dependent: :delete

	validates :name, presence: true

	def is_member?(user)
		GroupMembership.exists?(user_id: user.id, group_id: self.id)
	end
end
