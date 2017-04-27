class Api::CalendarController < Api::ApiController
  #before_action :authenticate_user!
  
  def event_dates
    id_event_type = params['event_type']
    id_campus = params['campus']
    host = params['host']

    web_calendar = params['web_calendar']
    email_user = request.headers['email']
    if email_user.nil? 
      email_user = params['email']
    end
    if id_event_type.eql? ""
      id_event_type = nil
    end
    if id_campus.eql? ""
      id_campus = nil
    end
    if host.eql? ""
      host = nil  
    end
    @event_dates = EventDate.generate_json(id_event_type, id_campus, email_user , web_calendar, host)
    render json: @event_dates
  end
  
  def global_events
    @json = EventDate.json_for_global_calendar()
    render json: @json
  end
  
  def agenda_events
    @json = Event.json_for_global_calendar()
    render json: @json
  end
  
  def user_events
    email_user = request.headers['email']
    if email_user.nil? 
      email_user = params['email']
    end
    web_calendar = params['web_calendar']
    @json = EventDate.get_user_bookings(email_user, web_calendar)
    render json: @json
  end
  
  def book
    unless params['id-event'].nil? 
      id_event_date = params['id-event']
      email_user = request.headers['email']
      if (email_user.nil?)

        email_user = current_user
      end

      if EventDate.check_availability(id_event_date, email_user)
        render json: {available: true, status: 200}
      else
        render json: {available: false, status: 200}
      end
    else
      render json: {description: 'Missing parameters',status:400}
    end
  end
  
  def cancel
    unless params['id-event'].nil?
      id_event_date = params['id-event'].to_i
      email_user = request.headers['email']
      if BookedHour.cancel_book(id_event_date, email_user)
        render json: {canceled: true, status: 200}
      else
        render json: {canceled: false, status: 200}
      end
    else
      render json: {description: 'Missing parameters',status:400}
    end
  end
  
  def big_cancel
    unless params['id-event'].nil?
      id_event= params['id-event'].to_i
      if Event.admin_cancel(id_event)
        render json: {canceled: true, status: 200}
      else
        render json: {canceled: false, status: 200}
      end
    else
      render json: {description: 'Missing parameters',status:400}
      
    end  
  end
  
  def admin_cancel
    unless params['id-event'].nil?
      id_event_date = params['id-event'].to_i
      if EventDate.admin_cancel(id_event_date)
        render json: {canceled: true, status: 200}
      else
        render json: {canceled: false, status: 200}
      end
    else
      render json: {description: 'Missing parameters',status:400}
      
    end
    
  end
end

