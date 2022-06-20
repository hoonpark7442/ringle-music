require "rails_helper"

RSpec.describe Groups::Creator, type: :service do
	let(:user) { create(:user) }
	let(:params) { { name: "my_group" } }

	context "유저가 group 생성 시" do
		it "group이 생성된다" do
	    expect do 
	    	described_class.call(user, params)
	    end.to change(Group, :count).by(1)
	  end

	  it "group을 생성한 유저는 그 group의 멤버가 된다" do
	    described_class.call(user, params)
	    group_membership = GroupMembership.last

	    expect(group_membership.user_id).to eq(user.id)
	  end

	  it "group을 생성한 유저는 그 group의 관리자가 된다" do
	    described_class.call(user, params)
	    member = GroupMembership.find_by(user_id: user.id)

	    expect(member.type_of_user).to eq("admin")
	  end
	end
	
end