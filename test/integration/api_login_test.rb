require 'test_helper'

class ApiLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:zhang)
  end

  test "login & logout normal" do
    post api_login_path, {email: @user.email, password: 'password'}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    token = response_json["token"]
    assert_not_nil token
    post api_logout_path, {token: token}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    id = response_json["id"]
    assert_not_nil id
  end
end
