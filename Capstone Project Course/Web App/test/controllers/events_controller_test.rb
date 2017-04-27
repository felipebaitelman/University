require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { capacity: @event.capacity, created_by: @event.created_by, day_id: @event.day_id, end_hour: @event.end_hour, event_type_id: @event.event_type_id, faculty_id: @event.faculty_id, host_id: @event.host_id, location: @event.location, start_hour: @event.start_hour } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { capacity: @event.capacity, created_by: @event.created_by, day_id: @event.day_id, end_hour: @event.end_hour, event_type_id: @event.event_type_id, faculty_id: @event.faculty_id, host_id: @event.host_id, location: @event.location, start_hour: @event.start_hour } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
