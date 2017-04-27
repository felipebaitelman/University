require 'test_helper'

class Stress2SurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stress2_survey = stress2_surveys(:one)
  end

  test "should get index" do
    get stress2_surveys_url
    assert_response :success
  end

  test "should get new" do
    get new_stress2_survey_url
    assert_response :success
  end

  test "should create stress2_survey" do
    assert_difference('Stress2Survey.count') do
      post stress2_surveys_url, params: { stress2_survey: { p10: @stress2_survey.p10, p11: @stress2_survey.p11, p12: @stress2_survey.p12, p13: @stress2_survey.p13, p14: @stress2_survey.p14, p1: @stress2_survey.p1, p2: @stress2_survey.p2, p3: @stress2_survey.p3, p4: @stress2_survey.p4, p5: @stress2_survey.p5, p6: @stress2_survey.p6, p7: @stress2_survey.p7, p8: @stress2_survey.p8, p9: @stress2_survey.p9, recommendation: @stress2_survey.recommendation, result: @stress2_survey.result, user_id: @stress2_survey.user_id } }
    end

    assert_redirected_to stress2_survey_url(Stress2Survey.last)
  end

  test "should show stress2_survey" do
    get stress2_survey_url(@stress2_survey)
    assert_response :success
  end

  test "should get edit" do
    get edit_stress2_survey_url(@stress2_survey)
    assert_response :success
  end

  test "should update stress2_survey" do
    patch stress2_survey_url(@stress2_survey), params: { stress2_survey: { p10: @stress2_survey.p10, p11: @stress2_survey.p11, p12: @stress2_survey.p12, p13: @stress2_survey.p13, p14: @stress2_survey.p14, p1: @stress2_survey.p1, p2: @stress2_survey.p2, p3: @stress2_survey.p3, p4: @stress2_survey.p4, p5: @stress2_survey.p5, p6: @stress2_survey.p6, p7: @stress2_survey.p7, p8: @stress2_survey.p8, p9: @stress2_survey.p9, recommendation: @stress2_survey.recommendation, result: @stress2_survey.result, user_id: @stress2_survey.user_id } }
    assert_redirected_to stress2_survey_url(@stress2_survey)
  end

  test "should destroy stress2_survey" do
    assert_difference('Stress2Survey.count', -1) do
      delete stress2_survey_url(@stress2_survey)
    end

    assert_redirected_to stress2_surveys_url
  end
end
