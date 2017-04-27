class Event < ApplicationRecord
    has_one :day
    has_one :host
    has_one :faculty
    has_one :event_type
    has_many :event_dates
    
    def self.json_for_global_calendar()
       @events = Event.all
       @json = Array.new
       @events.each do |e|

           event_type = EventType.where(:id => e.event_type_id).take
           host = User.where(:id => e.host_id).take
           campus = Faculty.where(:id => e.faculty_id).take
           day = Day.where(:id => e.day_id).take
           @json.push({ :id => e.id, :start => e.start_hour, :end => e.end_hour, :title => event_type.name, :host => host.name, :campus => campus.name, :location => e.location, :capacity => e.capacity, :dia => day.spanish_day})
        end
        
        return @json
    end
    
    def self.admin_cancel(id_event)
        @event=Event.where(:id => id_event).take
        @event_dates = EventDate.where(:event_id => id_event)
        @event_dates.each do |e|
            EventDate.admin_cancel(e.id)
        end

        @event.destroy
        
        return true    
    end
end

