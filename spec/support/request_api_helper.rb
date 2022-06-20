module RequestApiHelper
  def authenticated_header(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)

    auth_headers
  end

  def json_data
    JSON.parse(response.body)
  end
end