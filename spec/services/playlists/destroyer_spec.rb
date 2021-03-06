require "rails_helper"

RSpec.describe Playlists::Destroyer, type: :service do
	let(:user) { create(:user) }
	let(:artist) { create(:artist) }
  let(:album) { create(:album) }
  let!(:song) { create(:song, artist: artist, album: album) }
  let!(:another_song) { create(:song, artist: artist, album: album) }
  let(:user_playlist) { create(:playlist, playlistable: user) }

  let!(:user_playlist_songs) do
  	create(:playlist_song, playlist: user_playlist, song: song)
  	create(:playlist_song, playlist: user_playlist, song: another_song)
  end

  let(:remove_params) { song.id }

	context "유저가 playlist에 곡 삭제시" do
		it "유저의 playlist에 곡이 삭제된다" do
			described_class.call(user, remove_params)

			expect(user.playlist.song_lists.map(&:id)).to eq([another_song.id])
	  end
	end

	let(:group) { create(:group) }
	let(:group_playlist) { create(:playlist, playlistable: group) }

	let!(:group_playlist_songs) do
  	create(:playlist_song, playlist: group_playlist, song: song)
  	create(:playlist_song, playlist: group_playlist, song: another_song)
  end

	context "그룹 멤버가 playlist에 곡 삭제시" do
		it "그룹의 playlist에 곡이 삭제된다" do
	    described_class.call(group, remove_params)

	    song_ids = group.playlist.song_lists.map(&:id)

	    expect(song_ids).to eq([another_song.id])
	  end
	end
	
end