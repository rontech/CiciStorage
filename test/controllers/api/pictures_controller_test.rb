require 'test_helper'

class Api::PicturesControllerTest < ActionController::TestCase
  def setup
    @user = users(:zhang)
    @deactivated_user = users(:yamamoto);
  end

  test "login normal" do
    post :login, {email: @user.email, password: 'password'}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    assert_not_nil response_json["token"]
  end

  test "login failure with invalid request body" do
    post :login, {}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    assert_equal "Invalid request body.", response_json["error"]
  end

  test "login failure with deactivated account" do
    post :login, {email: @deactivated_user.email, password: 'password'}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    assert_equal "Account not activated.", response_json["error"]
  end

  test "login failure with invalid password" do
    post :login, {email: @user.email, password: 'invalid password'}.to_json
    assert_response :success
    response_json = JSON.parse(@response.body)
    assert_equal "Invalid email/password combination.", response_json["error"]
  end
end
