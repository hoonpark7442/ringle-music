require "rails_helper"

RSpec.describe Albums::Updater, type: :service do
	let(:artist) { create(:artist) }
	let(:album) { create(:album) }
	let!(:song) { create(:song, artist: artist, album: album) }

	let(:params) { { title: "updated title" } }

	context "album을 업데이트 하면" do
		it "album title이 적절히 업데이트 된다" do
	    described_class.call(album, params)
	    expect(album.title).to eq params[:title]
	  end

		it "song의 cached_album_name이 적절히 업데이트 된다" do
	    described_class.call(album, params)
	    song.reload

	    expect(song.cached_album_name).to eq params[:title]
	  end	  
	end
	
end