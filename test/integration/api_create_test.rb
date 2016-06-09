require 'test_helper'
require 'google_drive'
require 'uri'

class ApiCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:zhang)
  end

  test "Upload & download normal" do
    post api_login_path, {email: @user.email, password: 'password'}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    token = response_json["token"]
    assert_not_nil token
    
    file_dir = Rails.root.join('test/fixtures/files/')
    encoded_data = Base64.encode64(file_dir.join('test.jpg').read)
  
    post api_pictures_path, { name: "test.jpg", type: "image/jpeg",
                              data: encoded_data, token: token}.to_json  
    assert_response :success
    response_json = JSON.parse(@response.body)
    url = response_json["url"]
    assert_not_nil url 

    get api_picture_path(id: URI(url).path.split('/').last)
    assert_response :success
    assert_equal "image/jpeg", @response.content_type
    assert_equal  Base64.encode64(@response.body), encoded_data

    delete api_picture_path(id: URI(url).path.split('/').last), {token: token}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    id = response_json["id"]
    assert_not_nil id
    
    post api_logout_path, {token: token}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    id = response_json["id"]
    assert_not_nil id
  end
end
