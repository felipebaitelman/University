class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :logged
  before_action :admin
  
  include Authorize
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @current_user = current_user
  end

  # POST /events
  # POST /events.json
  def agenda_dating(start_time, end_time, initial_date, final_date, event, day)
    Time.zone = 'America/Santiago'
    Chronic.time_class = Time.zone
    
    start_time = Chronic.parse(start_time)
    end_time = Chronic.parse(end_time)
    initial_date = Chronic.parse(initial_date, :endian_precedence => :little)
    final_date = Chronic.parse(final_date, :endian_precedence => :little)
    
    start_hour = start_time.strftime("%H")
    start_minute = start_time.strftime("%M")
    end_hour = end_time.strftime("%H")
    end_minute = end_time.strftime("%M")
    
    dummy_date=Chronic.parse('1/1/2012')
    dummy_date=Chronic.parse('next ' + day.day, :now => dummy_date)
     
    dummy_date_start = dummy_date.change(hour: start_hour, min: start_minute)
    dummy_date_end= dummy_date.change(hour: end_hour, min: end_minute)
    
    event.update(start_hour: dummy_date_start, end_hour: dummy_date_end)
    return event
    
  end
  
  def create
    @event = Event.new(event_params)
    day = Day.where(id: params[:event][:day_id] ).take!
    initial_date = params[:event][:initial_date]
    final_date = params[:event][:final_date]
    start_time = params[:event][:start_hour]
    end_time = params[:event][:end_hour]
    host_id = User.where(id: params[:event][:host_id]).take!
    location = params[:event][:location]
    capacity = params[:event][:capacity]
    
    @event = agenda_dating(start_time, end_time, initial_date, final_date, @event, day)
    
    
    respond_to do |format|
      if @event.save

        id=EventDate.create_event_dates(initial_date, final_date, start_time, end_time, day, @event.id, host_id.id, location, capacity)
        format.html { redirect_to '/admin_calendar/display' }
        format.json { render :show, status: :created, location: @event }
       
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_type_id, :host_id, :faculty_id, :location, :capacity, :created_by, :start_hour, :end_hour, :day_id)
      
      #validate = params.require(:event).permit(:event_type_id, :host_id, :faculty_id, :location, :capacity, :created_by, :start_hour, :end_hour, :day_id)
      #validate[:start_hour] = Chronic.parse(validate[:start_hour])
      #start_hour = validate[:start_hour].strftime("%H")
      #start_minute = validate[:start_hour].strftime("%M")
      #puts start_hour.inspect
      #puts start_minute.inspect
      #return validate
    end
end
