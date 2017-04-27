class BookedHoursController < ApplicationController
  before_action :set_booked_hour, only: [:show, :edit, :update, :destroy]
  before_action :logged

  # GET /booked_hours
  # GET /booked_hours.json
  def index
    @booked_hours = BookedHour.all
  end

  # GET /booked_hours/1
  # GET /booked_hours/1.json
  def show
  end

  # GET /booked_hours/new
  def new
    @booked_hour = BookedHour.new
  end

  # GET /booked_hours/1/edit
  def edit
  end

  # POST /booked_hours
  # POST /booked_hours.json
  def create
    @booked_hour = BookedHour.new(booked_hour_params)

    respond_to do |format|
      if @booked_hour.save
        format.html { redirect_to @booked_hour }
        format.json { render :show, status: :created, location: @booked_hour }
      else
        format.html { render :new }
        format.json { render json: @booked_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /booked_hours/1
  # PATCH/PUT /booked_hours/1.json
  def update
    respond_to do |format|
      if @booked_hour.update(booked_hour_params)
        format.html { redirect_to @booked_hour }
        format.json { render :show, status: :ok, location: @booked_hour }
      else
        format.html { render :edit }
        format.json { render json: @booked_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booked_hours/1
  # DELETE /booked_hours/1.json
  def destroy
    @booked_hour.destroy
    respond_to do |format|
      format.html { redirect_to booked_hours_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booked_hour
      @booked_hour = BookedHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booked_hour_params
      params.require(:booked_hour).permit(:id_event_date, :id_user)
    end
end
