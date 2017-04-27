class Survey:: StressSurveysController < ApplicationController
  respond_to :html, :js, :json
  include Authorize

  before_action :logged
  before_action :admin, only: [:destroy]
  before_action :set_stress_survey, only: [:show, :destroy]

  def show
  end

  # GET /stress_surveys/new
  def new
    @stress_survey = StressSurvey.new
  end

  # POST /stress_surveys
  # POST /stress_surveys.json
  def create
    @stress_survey = StressSurvey.new(stress_survey_params)
    # End of result calculation
    @stress_survey.user_id = current_user.id
    b = @stress_survey.calculate_result(stress_survey_params)
    @stress_survey.result = b[0]
    @stress_survey.recommendations = b[1]
    @stress_survey.score = b[2]
    type = 'ansiedad'
    respond_to do |format|
      if @stress_survey.save
        format.html { redirect_to [:survey, @stress_survey] }
        format.json { render :show, status: :created, location: [survey, @stress_survey] }
        format.js {}
        RelaxucMailer.survey_results(type, @stress_survey.recommendations, current_user).deliver_later
      else
        format.html { render :new }
        format.json { render json: [:survey, @stress_survey.errors], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stress_surveys/1
  # DELETE /stress_surveys/1.json
  def destroy
    @stress_survey.destroy
    respond_to do |format|
      format.html { redirect_to stress_surveys_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stress_survey
      @stress_survey = StressSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stress_survey_params
      params.require(:stress_survey).permit(:user_id, :p1, :p2, :p3, :p4, :p5, :p6, :p7, :recommendations, :score)
    end
end
