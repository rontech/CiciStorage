require 'test_helper'

class PicturesOperationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:zhang)
  end

  test "picture operation" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Picture.count' do
      post pictures_path, picture: { file_name: "", content_type: "image/jpg" }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    assert_difference 'Picture.count', 1 do
      file_dir = Rails.root.join('test/fixtures/files/')
      post pictures_path, picture: {
        "temp_file" => Rack::Test::UploadedFile.new(file_dir.join('test.jpg').to_s, 'image/jpeg')
        }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match "test.jpg", response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_pic = @user.pictures.paginate(page: 1).first
    assert_difference 'Picture.count', -1 do
      delete picture_path(first_pic)
    end
    # 違うユーザーのプロフィールにアクセスする
    get user_path(users(:yamamoto))
    assert_select 'a', text: 'delete', count: 0
  end
end
