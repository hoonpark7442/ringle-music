require "rails_helper"

RSpec.describe Playlists::Creator, type: :service do
	let(:user) { create(:user) }
	let(:params) { { name: "my_playlist" } }
	let(:second_params) { { name: "my_another_playlist" } }

	context "유저가 playlist 생성 시" do
		it "playlist가 생성된다" do
	    expect do 
	    	described_class.call(user, params)
	    end.to change(Playlist, :count).by(1)
	  end

	  it "생성된 playlist의 playlistable id는 해당 유저의 id이며 type은 User이다" do
	    described_class.call(user, params)
	    playlist = Playlist.last

	    expect(playlist.playlistable_id).to eq(user.id)
	    expect(playlist.playlistable_type).to eq("User")
	  end

	  it "유저가 생성한 playlist는 해당 유저에 속한다" do
	    described_class.call(user, params)
	    playlist = Playlist.last

	    expect(playlist).to eq(user.playlist)
	  end

	  it "2개 이상의 플레이리스트는 생성할 수 없다" do
	  	described_class.call(user, params)
	  	another_playlist = described_class.call(user, second_params)

	  	expect(another_playlist.persisted?).to eq(false)
		end
	end

	let(:group) { create(:group) }
	let(:group_params) { { name: "group_playlist" } }
	let(:second_group_params) { { name: "group_another_playlist" } }

	context "group이 playlist 생성 시" do
		it "playlist가 생성된다" do
	    expect do 
	    	described_class.call(group, group_params)
	    end.to change(Playlist, :count).by(1)
	  end

	  it "생성된 playlist의 playlistable id는 해당 group의 id이며 type은 Group이다" do
	    described_class.call(group, params)
	    playlist = Playlist.last

	    expect(playlist.playlistable_id).to eq(group.id)
	    expect(playlist.playlistable_type).to eq("Group")
	  end

	  it "group이 생성한 playlist는 해당 group에 속한다" do
	    described_class.call(group, params)
	    playlist = Playlist.last

	    expect(playlist).to eq(group.playlist)
	  end

	  it "2개 이상의 플레이리스트는 생성할 수 없다" do
	  	described_class.call(group, params)
	  	another_playlist = described_class.call(group, second_params)

	  	expect(another_playlist.persisted?).to eq(false)
		end
	end
	
end