require 'test_helper'

class ImageSequencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_sequence = image_sequences(:one)
  end

  test "should get index" do
    get image_sequences_url
    assert_response :success
  end

  test "should get new" do
    get new_image_sequence_url
    assert_response :success
  end

  test "should create image_sequence" do
    assert_difference('ImageSequence.count') do
      post image_sequences_url, params: { image_sequence: {  } }
    end

    assert_redirected_to image_sequence_url(ImageSequence.last)
  end

  test "should show image_sequence" do
    get image_sequence_url(@image_sequence)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_sequence_url(@image_sequence)
    assert_response :success
  end

  test "should update image_sequence" do
    patch image_sequence_url(@image_sequence), params: { image_sequence: {  } }
    assert_redirected_to image_sequence_url(@image_sequence)
  end

  test "should destroy image_sequence" do
    assert_difference('ImageSequence.count', -1) do
      delete image_sequence_url(@image_sequence)
    end

    assert_redirected_to image_sequences_url
  end
end
