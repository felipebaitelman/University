require 'test_helper'

class LongAudioControllerTest < ActionDispatch::IntegrationTest
  test "should get display" do
    get long_audio_display_url
    assert_response :success
  end

end
