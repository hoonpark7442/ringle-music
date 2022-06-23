require "rails_helper"

RSpec.describe PlaylistQueue, type: :lib do
	let(:user) { create(:user) }
	let(:artist) { create(:artist) }
  let(:album) { create(:album) }
  let!(:song) { create(:song, artist: artist, album: album) }
  let!(:second_song) { create(:song, artist: artist, album: album) }
  let!(:third_song) { create(:song, artist: artist, album: album) }
  let(:playlist) { create(:playlist, playlistable: user) }
  let!(:playlist_songs) do
  	create(:playlist_song, playlist: playlist, song: song)
  	create(:playlist_song, playlist: playlist, song: second_song)
  	create(:playlist_song, playlist: playlist, song: third_song)
  end

  it "100개 이상의 곡 추가시 최신순으로 100개의 in_list가 리턴된다" do
		new_songs = []
		(1..101).each do |id|
			song = create(:song, title: "song-#{id}", artist: artist, album: album)
			new_songs.unshift(song.id)
		end

		pl = playlist

		playlist_queue = described_class.new(pl.song_lists)
		playlist_queue.push(new_songs)

		expect(new_songs.slice(...100)).to eq(playlist_queue.in_list)
  end

	context "기존 플레이리스트의 곡 개수와 새로 추가하려는 곡 개수의 합이 100을 넘을 경우" do
	  it "플레이리스트 곡 리스트에서 오래된 순으로 100을 넘어서는 개수만큼 out_list에 담겨 리턴된다" do
	  	new_songs = []
			(1..99).each do |id|
				song = create(:song, title: "song-#{id}", artist: artist, album: album)
				new_songs.unshift(song.id)
			end

			pl = playlist

			playlist_queue = described_class.new(pl.song_lists)
			playlist_queue.push(new_songs)

			expected_result = [pl.song_lists.map(&:id)[-1], pl.song_lists.map(&:id)[-2]]

			expect(expected_result).to match_array(playlist_queue.out_list)
	  end
	end

	context "기존 플레이리스트의 곡 개수와 새로 추가하려는 곡 개수의 합이 100을 넘지 않을 경우" do
	  it "out_list는 빈 어레이가 리턴된다" do
	  	new_songs = []
			(1..97).each do |id|
				song = create(:song, title: "song-#{id}", artist: artist, album: album)
				new_songs.unshift(song.id)
			end

			pl = playlist

			playlist_queue = described_class.new(pl.song_lists)
			playlist_queue.push(new_songs)

			expect([]).to match_array(playlist_queue.out_list)
	  end
	end
end