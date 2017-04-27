require 'test_helper'

class SleepSurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sleep_survey = sleep_surveys(:one)
  end

  test "should get index" do
    get sleep_surveys_url
    assert_response :success
  end

  test "should get new" do
    get new_sleep_survey_url
    assert_response :success
  end

  test "should create sleep_survey" do
    assert_difference('SleepSurvey.count') do
      post sleep_surveys_url, params: { sleep_survey: { p10: @sleep_survey.p10, p11: @sleep_survey.p11, p12: @sleep_survey.p12, p1: @sleep_survey.p1, p2: @sleep_survey.p2, p3: @sleep_survey.p3, p4: @sleep_survey.p4, p5: @sleep_survey.p5, p6: @sleep_survey.p6, p7: @sleep_survey.p7, p8: @sleep_survey.p8, p9: @sleep_survey.p9, result: @sleep_survey.result, user_id: @sleep_survey.user_id } }
    end

    assert_redirected_to sleep_survey_url(SleepSurvey.last)
  end

  test "should show sleep_survey" do
    get sleep_survey_url(@sleep_survey)
    assert_response :success
  end

  test "should get edit" do
    get edit_sleep_survey_url(@sleep_survey)
    assert_response :success
  end

  test "should update sleep_survey" do
    patch sleep_survey_url(@sleep_survey), params: { sleep_survey: { p10: @sleep_survey.p10, p11: @sleep_survey.p11, p12: @sleep_survey.p12, p1: @sleep_survey.p1, p2: @sleep_survey.p2, p3: @sleep_survey.p3, p4: @sleep_survey.p4, p5: @sleep_survey.p5, p6: @sleep_survey.p6, p7: @sleep_survey.p7, p8: @sleep_survey.p8, p9: @sleep_survey.p9, result: @sleep_survey.result, user_id: @sleep_survey.user_id } }
    assert_redirected_to sleep_survey_url(@sleep_survey)
  end

  test "should destroy sleep_survey" do
    assert_difference('SleepSurvey.count', -1) do
      delete sleep_survey_url(@sleep_survey)
    end

    assert_redirected_to sleep_surveys_url
  end
end
