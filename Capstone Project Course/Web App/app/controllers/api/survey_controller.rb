class Api::SurveyController < Api::ApiController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def GAD7
    gad7 = StressSurvey.new(user_id: current_user.id, score: params[:score])
    if gad7.save
      render json: {
          "success": true
      }
    else
      render json: {
          "success": false
      }
    end
  end

  def stress
    stress = Stress2Survey.new(user_id: current_user.id, score: params[:score])
    if stress.save
      render json: {
          "success": true
      }
    else
      render json: {
          "success": false
      }
    end  end

  def sleep
    sleep = SleepSurvey.new(user_id: current_user.id, score: params[:score])
    if sleep.save
      render json: {
          "success": true
      }
    else
      render json: {
          "success": false
      }
    end
  end

end
