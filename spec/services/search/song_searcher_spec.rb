require "rails_helper"

RSpec.describe Search::SongSearcher, type: :service do
	let(:user) { create(:user) }

	let(:artist) { create(:artist) }
  let(:album) { create(:album) }
  let!(:song) { create(:song, title: "query", favorite_counts: 50, created_at: 3.days.ago, artist: artist, album: album) }

  let(:artist_2) { create(:artist, name: "query") }
  let(:album_2) { create(:album) }
  let!(:song_with_query_in_artist) { create(:song, favorite_counts: 150, created_at: 2.days.ago, artist: artist_2, album: album_2) }

	let(:artist_3) { create(:artist) }
  let(:album_3) { create(:album, title: "query") }
  let!(:song_with_query_in_album) { create(:song, favorite_counts: 100, created_at: 1.days.ago, artist: artist_3, album: album_3) }  

  let(:params) { { q: "query" } }
  let(:params_with_latest) { { q: "query", sort_by: "latest" } }
  let(:params_with_favorites) { { q: "query", sort_by: "favorite" } }

	context "노래 검색 시" do
		it "title, artist name, album name 순으로 랭크가 매겨져 리턴된다" do
	    search_result = described_class.call(params)

	    ids = search_result.map do |tuple|
	    	tuple["id"]
	    end
	    
	    expected_result = [song.id, song_with_query_in_artist.id, song_with_query_in_album.id]

	    expect(ids).to eq(expected_result)
	  end

	  it "최신순 정렬 시 적절히 정렬이 된다" do
	  	search_result = described_class.call(params_with_latest)

	    ids = search_result.map do |tuple|
	    	tuple["id"]
	    end
	    
	    expected_result = [song_with_query_in_album.id, song_with_query_in_artist.id, song.id]

	    expect(ids).to eq(expected_result)
	  end

	  it "인기순 정렬 시 적절히 정렬이 된다" do
	  	search_result = described_class.call(params_with_favorites)

	    ids = search_result.map do |tuple|
	    	tuple["id"]
	    end
	    
	    expected_result = [song_with_query_in_artist.id, song_with_query_in_album.id, song.id]

	    expect(ids).to eq(expected_result)
	  end
	end
end