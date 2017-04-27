require 'test_helper'

class StressSurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stress_survey = stress_surveys(:one)
  end

  test "should get index" do
    get stress_surveys_url
    assert_response :success
  end

  test "should get new" do
    get new_stress_survey_url
    assert_response :success
  end

  test "should create stress_survey" do
    assert_difference('StressSurvey.count') do
      post stress_surveys_url, params: { stress_survey: { p1: @stress_survey.p1, p2: @stress_survey.p2, p3: @stress_survey.p3, p4: @stress_survey.p4, p5: @stress_survey.p5, p6: @stress_survey.p6, p7: @stress_survey.p7, user_id: @stress_survey.user_id } }
    end

    assert_redirected_to stress_survey_url(StressSurvey.last)
  end

  test "should show stress_survey" do
    get stress_survey_url(@stress_survey)
    assert_response :success
  end

  test "should get edit" do
    get edit_stress_survey_url(@stress_survey)
    assert_response :success
  end

  test "should update stress_survey" do
    patch stress_survey_url(@stress_survey), params: { stress_survey: { p1: @stress_survey.p1, p2: @stress_survey.p2, p3: @stress_survey.p3, p4: @stress_survey.p4, p5: @stress_survey.p5, p6: @stress_survey.p6, p7: @stress_survey.p7, user_id: @stress_survey.user_id } }
    assert_redirected_to stress_survey_url(@stress_survey)
  end

  test "should destroy stress_survey" do
    assert_difference('StressSurvey.count', -1) do
      delete stress_survey_url(@stress_survey)
    end

    assert_redirected_to stress_surveys_url
  end
end
