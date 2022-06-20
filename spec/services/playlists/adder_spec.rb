require "rails_helper"

RSpec.describe Playlists::Adder, type: :service do
	let(:user) { create(:user) }
	let(:artist) { create(:artist) }
  let(:album) { create(:album) }
  let!(:song) { create(:song, artist: artist, album: album) }
  let!(:another_song) { create(:song, artist: artist, album: album) }
  let(:user_playlist) { create(:playlist, playlistable: user) }

  let(:params) { [song.id, another_song.id] }

	context "유저가 playlist에 곡 추가시" do
		it "유저의 playlist에 곡이 추가된다" do
			user_playlist
	    described_class.call(user, params)

	    song_ids = user.playlist.song_lists.map(&:id)

	    expect(song_ids).to eq(params)
	  end
	end

	let(:group) { create(:group) }
	let(:group_playlist) { create(:playlist, playlistable: group) }

	context "그룹 멤버가 playlist에 곡 추가시" do
		it "그룹의 playlist에 곡이 추가된다" do
			group_playlist
	    described_class.call(group, params)

	    song_ids = group.playlist.song_lists.map(&:id)

	    expect(song_ids).to eq(params)
	  end
	end
	
end