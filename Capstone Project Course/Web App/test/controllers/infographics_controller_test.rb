require 'test_helper'

class InfographicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @infographic = infographics(:one)
  end

  test "should get index" do
    get infographics_url
    assert_response :success
  end

  test "should get new" do
    get new_infographic_url
    assert_response :success
  end

  test "should create infographic" do
    assert_difference('Infographic.count') do
      post infographics_url, params: { infographic: { added_by: @infographic.added_by, date_added: @infographic.date_added, description: @infographic.description, name: @infographic.name, starting_content: @infographic.starting_content } }
    end

    assert_redirected_to infographic_url(Infographic.last)
  end

  test "should show infographic" do
    get infographic_url(@infographic)
    assert_response :success
  end

  test "should get edit" do
    get edit_infographic_url(@infographic)
    assert_response :success
  end

  test "should update infographic" do
    patch infographic_url(@infographic), params: { infographic: { added_by: @infographic.added_by, date_added: @infographic.date_added, description: @infographic.description, name: @infographic.name, starting_content: @infographic.starting_content } }
    assert_redirected_to infographic_url(@infographic)
  end

  test "should destroy infographic" do
    assert_difference('Infographic.count', -1) do
      delete infographic_url(@infographic)
    end

    assert_redirected_to infographics_url
  end
end
