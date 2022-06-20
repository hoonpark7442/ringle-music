class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  has_many :group_memberships, dependent: :delete_all
  has_many :groups, through: :group_memberships
  has_one :playlist, as: :playlistable, dependent: :delete

  validates :email, :password, presence: true, :on => :create
  validates :email, uniqueness: true
end
