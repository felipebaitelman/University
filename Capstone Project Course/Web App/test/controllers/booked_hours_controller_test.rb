require 'test_helper'

class BookedHoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booked_hour = booked_hours(:one)
  end

  test "should get index" do
    get booked_hours_url
    assert_response :success
  end

  test "should get new" do
    get new_booked_hour_url
    assert_response :success
  end

  test "should create booked_hour" do
    assert_difference('BookedHour.count') do
      post booked_hours_url, params: { booked_hour: { id_event_date: @booked_hour.id_event_date, id_user: @booked_hour.id_user } }
    end

    assert_redirected_to booked_hour_url(BookedHour.last)
  end

  test "should show booked_hour" do
    get booked_hour_url(@booked_hour)
    assert_response :success
  end

  test "should get edit" do
    get edit_booked_hour_url(@booked_hour)
    assert_response :success
  end

  test "should update booked_hour" do
    patch booked_hour_url(@booked_hour), params: { booked_hour: { id_event_date: @booked_hour.id_event_date, id_user: @booked_hour.id_user } }
    assert_redirected_to booked_hour_url(@booked_hour)
  end

  test "should destroy booked_hour" do
    assert_difference('BookedHour.count', -1) do
      delete booked_hour_url(@booked_hour)
    end

    assert_redirected_to booked_hours_url
  end
end
