require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
  def setup
    @user = users(:zhang)
    @picture = pictures(:file1)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Picture.count' do
      post :create, picture: {file_name: "file_xxx", content_type: "image/jpg", url_key: Picture.gen_key, user_id: @user.id  }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Picture.count' do
      delete :destroy, id: @picture
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong picture" do
    log_in_as(users(:zhang))
    pic  = pictures(:file4)
    assert_no_difference 'Picture.count' do
      delete :destroy, id: pic
    end
    assert_redirected_to root_url
  end
end
