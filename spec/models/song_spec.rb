require 'rails_helper'

RSpec.describe Song, type: :model do
  let(:artist) { create(:artist) }
  let(:album) { create(:album, artist: artist) }
  let(:song) { create(:song, artist: artist, album: album) }

  context "before save 콜백이 트리거되면" do
    it "저장 시 cached_artist_name을 assign한다" do
      expect(song.cached_artist_name).to eq(artist.name)
    end

    it "저장 시 cached_album_name을 assign한다" do
      expect(song.cached_album_name).to eq(album.title)
    end
  end

end
