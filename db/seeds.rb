# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

return if Rails.env.production?

puts "seeding fake data is working on now\n\n"

iu = Artist.create!(
	    name: '아이유'
	  )
iu_album = Album.create!(
				  	title: Faker::Music.album,
				  	artist: iu
					)
10.times do
  Song.create!(
		artist: iu,
		album: iu_album,
  	title: Faker::Artist.name,
  	favorite_counts: rand(1..1000)
  )
end


10.times do
  artist = Artist.create!(
    name: Faker::Kpop.girl_groups
  )

  album = Album.create!(
  	title: Faker::Music.album,
  	artist: artist
  )

  10.times do 
  	Song.create!(
  		artist: artist,
  		album: album,
	  	title: Faker::Artist.name,
	  	favorite_counts: rand(1..1000)
	  )
  end
end