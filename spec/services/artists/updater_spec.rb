require "rails_helper"

RSpec.describe Artists::Updater, type: :service do
	let(:artist) { create(:artist) }
	let(:album) { create(:album) }
	let!(:song) { create(:song, artist: artist, album: album) }

	let(:params) { { name: "updated name" } }

	context "artist를 업데이트 하면" do
		it "artist name이 적절히 업데이트 된다" do
	    described_class.call(artist, params)
	    expect(artist.name).to eq params[:name]
	  end

		it "song의 cached_artist_name이 적절히 업데이트 된다" do
	    described_class.call(artist, params)
	    song.reload

	    expect(song.cached_artist_name).to eq params[:name]
	  end	  
	end
	
end