class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  has_many :group_memberships, dependent: :delete_all
  has_many :groups, through: :group_memberships
  has_many :playlists, as: :playlistable, dependent: :delete_all

  validates :email, :password, presence: true, :on => :create
  validates :email, uniqueness: true
end
