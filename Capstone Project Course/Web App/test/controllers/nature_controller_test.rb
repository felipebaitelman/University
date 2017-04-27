require 'test_helper'

class NatureControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get nature_show_url
    assert_response :success
  end

end
