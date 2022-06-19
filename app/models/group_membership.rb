class GroupMembership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, :group_id, :type_of_user, presence: true
end
