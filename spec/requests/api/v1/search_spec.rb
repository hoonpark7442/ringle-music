require 'rails_helper'

RSpec.describe "Api::V1::Search", type: :request do
  let(:user) { create(:user) }
  
  let(:artist) { create(:artist) }
  let(:album) { create(:album) }
  let!(:song) { create(:song, title: "query", artist: artist, album: album) }

  let(:artist_2) { create(:artist, name: "query") }
  let(:album_2) { create(:album) }
  let!(:song_with_query_in_artist) { create(:song, artist: artist_2, album: album_2) }

  let(:artist_3) { create(:artist) }
  let(:album_3) { create(:album, title: "query") }
  let!(:song_with_query_in_album) { create(:song, artist: artist_3, album: album_3) }  

  it "default 검색시 http staus 200 리턴한다" do
    headers = authenticated_header(user)
    get "/api/v1/search", params: { q: "query" }, headers: headers
    
    expect(response).to have_http_status(200)
  end

  it "최신순 검색시 http staus 200 리턴한다" do
    headers = authenticated_header(user)
    get "/api/v1/search", params: { q: "query", sort_by: "latest" }, headers: headers
    
    expect(response).to have_http_status(200)
  end

  it "인기순 검색시 http staus 200 리턴한다" do
    headers = authenticated_header(user)
    get "/api/v1/search", params: { q: "query", sort_by: "favorite" }, headers: headers
    
    expect(response).to have_http_status(200)
  end

  it "검색시 리턴되는 데이터는 노래의 id, title, artist name, albume name, favorite count 이다" do
    headers = authenticated_header(user)
    get "/api/v1/search", params: { q: "query" }, headers: headers
    
    expected_data_list = ["id", "title", "artist_name", "album_title", "favorite_counts"]
    
    expect(json_data["results"][0].keys).to match_array(expected_data_list)
  end
end
