class Survey:: Stress2SurveysController < ApplicationController
  respond_to :html, :js, :json
  include Authorize

  before_action :logged
  before_action :admin, only: [:destroy]
  before_action :set_stress2_survey, only: [:show, :destroy]

  def show
  end

  # GET /stress2_surveys/new
  def new
    @stress2_survey = Stress2Survey.new
  end

  # POST /stress2_surveys
  # POST /stress2_surveys.json
  def create
    @stress2_survey = Stress2Survey.new(stress2_survey_params)
    @stress2_survey.user_id = current_user.id
    b = @stress2_survey.calculate_result(stress2_survey_params)
    @stress2_survey.result = b[0]
    @stress2_survey.recommendation = b[1]
    @stress2_survey.score = b[2]
    type = 'estrés'
    respond_to do |format|
      if @stress2_survey.save

        format.html { redirect_to [:survey, @stress2_survey] }
        format.json { render :show, status: :created, location: [:survey, @stress2_survey] }
        format.js {}
        RelaxucMailer.survey_results(type, @stress2_survey.recommendation, current_user).deliver_later
      else
        format.html { render :new }
        format.json { render json: [:survey, @stress2_survey.errors], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stress2_surveys/1
  # DELETE /stress2_surveys/1.json
  def destroy
    @stress2_survey.destroy
    respond_to do |format|
      format.html { redirect_to survey_stress2_survey_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stress2_survey
      @stress2_survey = Stress2Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stress2_survey_params
      params.require(:stress2_survey).permit(:user_id, :recommendation, :p1, :p2, :p3, :p4, :p5, :p6, :p7, :p8, :p9, :p10, :p11, :p12, :p13, :p14, :score)
    end
end
