# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

return if Rails.env.production?

puts "seeding fake data is working on now\n\n"

ActiveRecord::Base.transaction do
	###################################
  # Users
  ###################################

	# User.destroy_all
	ActiveRecord::Base.connection.execute("TRUNCATE users CASCADE;")

	user1 = User.create(
    email: 'test@test.com',
    password: '123123',
    name: 'test_user'
  )

  user2 = User.create(
    email: 'test2@test.com',
    password: '123123',
    name: 'test_user2'
  )

  ###################################
  # Groups
  ###################################

  # Group.destroy_all
  ActiveRecord::Base.connection.execute("TRUNCATE groups CASCADE;")

  group1 = Group.create(
  	name: 'test_group'
  )

  ###################################
  # Group Memberships
  ###################################

  # GroupMembership.destroy_all
  ActiveRecord::Base.connection.execute("TRUNCATE group_memberships CASCADE;")

  GroupMembership.create(
  	user: user1,
  	group: group1,
  	type_of_user: 'admin'
  )

  ###################################
  # Artists, Albums, Songs
  ###################################

  # Artist.destroy_all
  ActiveRecord::Base.connection.execute("TRUNCATE artists CASCADE;")

  # ---------------------------------
  # ---------------------------------
  # 아이유 검색 관련 start

  iu = Artist.create!(
    name: '아이유'
  )

  iu_album = Album.create(
  	title: Faker::Music.album,
  	artist: iu
	)

  Song.create(
		artist: iu,
		album: iu_album,
  	title: Faker::Book.title,
  	favorite_counts: rand(1..1000)
  )

  another_artist = Artist.create!(
    name: 'another_artist'
  )

  another_album = Album.create(
  	title: '아이유',
  	artist: another_artist
	)

  Song.create(
		artist: another_artist,
		album: another_album,
  	title: Faker::Book.title,
  	favorite_counts: rand(1..1000)
  )

  another_sec_artist = Artist.create!(
    name: 'another_sec_artist'
  )

  another_sec_album = Album.create(
  	title: Faker::Music.album,
  	artist: another_sec_artist
	)

  Song.create(
		artist: another_sec_artist,
		album: another_sec_album,
  	title: '아이유',
  	favorite_counts: rand(1..1000)
  )

  # 아이유 검색 관련 end
  # ---------------------------------
  # ---------------------------------

	10.times do
	  artist = Artist.create(
	    name: Faker::Kpop.girl_groups
	  )

	  album = Album.create(
	  	title: Faker::Music.album,
	  	artist: artist
	  )

	  30.times do 
	  	Song.create(
	  		artist: artist,
	  		album: album,
		  	title: Faker::Book.title,
		  	favorite_counts: rand(1..1000)
		  )
	  end
	end


	###################################
  # Playlist
  ###################################

  # ActiveRecord::Base.connection.execute("TRUNCATE playlist_songs;")
  ActiveRecord::Base.connection.execute("TRUNCATE playlists CASCADE;")

  # Playlist.destroy_all

  user_playlist = Playlist.create(
  	name: 'user_playist',
  	playlistable: user1
  )

  group_playlist = Playlist.create(
  	name: 'group_playist',
  	playlistable: group1
  )


  ###################################
  # Playlist Songs
  ###################################

  # PlaylistSong.destroy_all

  song_lists = Song.limit(95).order("RANDOM()")

  song_lists.each do |song|
  	PlaylistSong.create(
	  	playlist: user_playlist,
	  	song: song
	  )
  end

  group_song_lists = Song.limit(95).order("RANDOM()")

  group_song_lists.each do |song|
  	PlaylistSong.create(
	  	playlist: group_playlist,
	  	song: song
	  )
  end

end




