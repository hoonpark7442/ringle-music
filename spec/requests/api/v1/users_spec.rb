require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { create(:user) }
  # let(:requet) { post "/api/v1/users/playlist" }

  it "user는 로그인해야 한다" do
    headers = authenticated_header(user)
    post "/api/v1/users/playlist", headers: headers
    
    puts "======="
    p json_data
    puts "======="
  end
end
