class Survey:: SleepSurveysController < ApplicationController
  respond_to :html, :js, :json
  include Authorize

  before_action :logged
  before_action :admin, only: [:destroy]
  before_action :set_sleep_survey, only: [:show, :destroy]

  def show
  end

  # GET /sleep_surveys/new
  def new
    @sleep_survey = SleepSurvey.new
  end

  # POST /sleep_surveys
  # POST /sleep_surveys.json
  def create
    @sleep_survey = SleepSurvey.new(sleep_survey_params)
    @sleep_survey.user_id = current_user.id
    b = @sleep_survey.calculate_result(sleep_survey_params)
    @sleep_survey.result = b[0]
    @sleep_survey.recommendations = b[1]
    @sleep_survey.score = b[2]
    type = 'sueño'
    respond_to do |format|
      if @sleep_survey.save

        format.html { redirect_to [:survey, @sleep_survey] }
        format.json { render :show, status: :created, location: [:survey, @sleep_survey] }
        format.js {}
        RelaxucMailer.survey_results(type, @sleep_survey.recommendations, current_user).deliver_later
      else
        format.html { render :new }
        format.json { render json: [:survey, @sleep_survey.errors], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sleep_surveys/1
  # DELETE /sleep_surveys/1.json
  def destroy
    @sleep_survey.destroy
    respond_to do |format|
      format.html { redirect_to survey_sleep_surveys_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sleep_survey
    @sleep_survey = SleepSurvey.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sleep_survey_params
    params.require(:sleep_survey).permit(:user_id, :p1, :p2, :p3, :p4, :p5, :p6, :p7, :p8, :p9, :p10, :p11, :p12, :result, :recommendations, :score)
  end
end
