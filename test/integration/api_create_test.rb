require 'test_helper'
require "google_drive"

class ApiCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:zhang)
  end

  test "Upload normal" do
    post api_login_path, {email: @user.email, password: 'password'}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    token = response_json["token"]
    assert_not_nil token
    
    file_dir = Rails.root.join('test/fixtures/files/')
    encoded_data = Base64.encode64(file_dir.join('test.jpg').read)
  
    post api_pictures_path, { name: "test.jpg", type: "image/jpeg", data: encoded_data, token: token}.to_json  
    assert_response :success
    response_json = JSON.parse(@response.body)
    url = response_json["url"]
    assert_not_nil url 

    p "url=#{url}"
    
    post api_logout_path, {token: token}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    id = response_json["id"]
    assert_not_nil id
  end
end
