require 'rails_helper'

RSpec.describe "Api::V1::Playlists", type: :request do
  let(:user) { create(:user) }
  let(:params) { { playlist: { name: "my_playlist" } }.to_json }

  let(:artist) { create(:artist) }
  let(:album) { create(:album) }
  let(:playlist) { create(:playlist, playlistable: user ) }
  let!(:song) { create(:song, artist: artist, album: album) }
  let!(:another_song) { create(:song, artist: artist, album: album) }
  
  it "user가 자신의 playlist에 곡을 추가 가능하다" do
    playlist
    headers = authenticated_header(user)
    post "/api/v1/users/playlist/song-lists", params: { song_ids: [song.id, another_song.id] }.to_json, headers: headers

    expect(json_data["playlist_id"]).to eq(playlist.id)
  end

  let(:group) { create(:group) }
  let(:group_playlist) { create(:playlist, playlistable: group ) }
  let!(:group_membership) { create(:group_membership, :admin, user: user, group: group) }
  let(:another_user) { create(:user) }

  it "그룹멤버면 추가 가능하다" do
    group_playlist
    headers = authenticated_header(user)
    post "/api/v1/groups/#{group.id}/playlist/song-lists", params: { song_ids: [song.id, another_song.id] }.to_json, headers: headers

    expect(json_data["playlist_id"]).to eq(group_playlist.id)
  end

  it "그룹멤버만 추가 가능하다" do
    group_playlist
    headers = authenticated_header(another_user)
    post "/api/v1/groups/#{group.id}/playlist/song-lists", params: { song_ids: [song.id, another_song.id] }.to_json, headers: headers

    expect(response).to have_http_status(401)
  end

  it "그룹멤버면 삭제 가능하다" do
    group_playlist
    headers = authenticated_header(user)
    post "/api/v1/groups/#{group.id}/playlist/song-lists", params: { song_ids: [song.id, another_song.id] }.to_json, headers: headers

    expect do
      delete "/api/v1/groups/#{group.id}/playlist/song-lists", params: { song_ids: song.id }.to_json, headers: headers
    end.to change(PlaylistSong, :count).by(-1)
  end

  it "그룹멤버만 삭제 가능하다" do
    group_playlist
    headers = authenticated_header(another_user)
    post "/api/v1/groups/#{group.id}/playlist/song-lists", params: { song_ids: [song.id, another_song.id] }.to_json, headers: headers

    expect do
      delete "/api/v1/groups/#{group.id}/playlist/song-lists", params: { song_ids: song.id }.to_json, headers: headers
    end.to_not change{PlaylistSong.count}
  end
end
