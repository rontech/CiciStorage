require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,       "Cici Storage" 
    assert_equal full_title("Help"), "Help | Cici Storage"
  end
end
