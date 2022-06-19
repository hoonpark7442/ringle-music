class Artist < ApplicationRecord
	has_many :albums, dependent: :delete_all
	has_many :songs, dependent: :delete_all
	
	validates :name, presence: true
end
