class EventDatesController < ApplicationController
  before_action :set_event_date, only: [:show, :edit, :update, :destroy]
  before_action :logged
  
  respond_to :json, :html
  # GET /event_dates
  # GET /event_dates.json
  def index
    @event_dates = EventDate.all
  end

  # GET /event_dates/1
  # GET /event_dates/1.json
  def show
  end
  
  def json
    json = EventDate.generate_json()
    respond_to do |format|
      format.json {render json: json, status: 200}
    end
  end

  # GET /event_dates/new
  def new
    @event_date = EventDate.new
  end

  # GET /event_dates/1/edit
  def edit
    @teachers = User.where(admin:true)
  end

  # POST /event_dates
  # POST /event_dates.json
  def create
    @event_date = EventDate.new(event_date_params)

    respond_to do |format|
      if @event_date.save
        format.html { redirect_to @event_date }
        format.json { render :show, status: :created, location: @event_date }
      else
        format.html { render :new }
        format.json { render json: @event_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_dates/1
  # PATCH/PUT /event_dates/1.json
  def update
    respond_to do |format|
      if @event_date.update(event_date_params)
        EventDate.admin_edit(@event_date.id)
        format.html { redirect_to '/admin_calendar_global/display' }
        format.json { render :show, status: :ok, location: @event_date }
      else
        format.html { render :edit }
        format.json { render json: @event_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_dates/1
  # DELETE /event_dates/1.json
  def destroy
    @event_date.destroy
    respond_to do |format|
      format.html { redirect_to event_dates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_date
      @event_date = EventDate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_date_params
      params.require(:event_date).permit(:event_id, :start_date, :end_date, :host_id, :location, :capacity)
    end
end
