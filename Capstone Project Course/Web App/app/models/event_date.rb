class EventDate < ApplicationRecord
    belongs_to :event
    belongs_to :booked_hour,  optional: true

    Time.zone = 'America/Santiago'
    Chronic.time_class = Time.zone
    
    
    def self.admin_cancel(id_event_date)
        @event_date=EventDate.where(:id => id_event_date).take
        BookedHour.admin_cancel(id_event_date, @event_date)
        @event_date.destroy
        
        return true    
    end
    
    def self.admin_edit(id_event_date)
        @event_date=EventDate.where(:id => id_event_date).take
        BookedHour.admin_edit(id_event_date, @event_date)
        
        
        return true    
    end
    
    def self.check_availability(id_event_date, email_user)
        user = User.where(:email => email_user).take
        @event_date = EventDate.where(:id => id_event_date).take
        user_booked= BookedHour.check_user_booked(@event_date, user)
        if @event_date.remaining_capacity > 0 and !(user_booked)
            BookedHour.book(@event_date, user.id)
            return true
        else
            return false
        end
    end

    def self.json_for_global_calendar()
       @event_dates = EventDate.all

       @json = Array.new
       @event_dates.each do |e|
           event = Event.where(:id => e.event_id).take
           event_type = EventType.where(:id => event.event_type_id).take
           faculty = Faculty.where(:id => event.faculty_id).take
           host_real = User.where(:id => e.host_id).take
           
           @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host =>host_real.email, :location => e.location, 
                    :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name})
        end
        return @json
    end
    
    def self.get_user_bookings(email_user, web_calendar)
        if (web_calendar.nil?)
            web_calendar = false
        else
            web_calendar = true
        end
        puts web_calendar.inspect
       @event_dates = EventDate.all
       user = User.where(:email => email_user).take
       @json = Array.new
       @event_dates.each do |e|
           event = Event.where(:id => e.event_id).take
           event_type = EventType.where(:id => event.event_type_id).take
           faculty = Faculty.where(:id => event.faculty_id).take
           host_real = User.where(:id => e.host_id).take
           check_user_booked = BookedHour.check_user_booked(e, user)
           if check_user_booked
               if (web_calendar)
                   @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host =>host_real.name, :location => e.location, 
                    :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
               else
                   @json.push({ :id => e.id, :start_date => e.start_date, :end_date => e.end_date,:host => host_real.name, :location => e.location, 
                    :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :event_type => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                end
           end
       end
       return @json
       end

    def self.generate_json(id_event_type, id_campus, email_user, web_calendar, host_id) #may need refactoring, generates the json for android depending on the filters the user applies
        user = User.where(:email => email_user).take
        host = nil
        if !(host_id.nil?)
            host = User.where(:id => host_id).take
        end
        if (web_calendar.nil?)
            web_calendar = false
        else
            web_calendar = true
        end

        if !(id_event_type.nil?)
            if !(id_campus.nil?)
                #query with event type and campus restrictions
                id_campus = id_campus.to_i
                id_event_type = id_event_type.to_i
                @event_dates = EventDate.all
                @json = Array.new
                @event_dates.each do |e|
                    event = Event.where(:id => e.event_id).take
                    event_type = EventType.where(:id => event.event_type_id).take
                    faculty = Faculty.where(:id => event.faculty_id).take
                    host_real = User.where(:id => e.host_id).take
                    check_user_booked = BookedHour.check_user_booked(e, user)

                    if(!(user.academic_type.eql? 'Funcionario') and event_type.name.eql? "Taller de Yoga")
                        next
                    end
                    if(user.academic_type.eql? 'Funcionario' and !(event_type.name.eql? "Taller de Yoga"))
                        next
                    end
                    if (e.remaining_capacity>0 or check_user_booked) and (event_type.id == id_event_type) and (faculty.id == id_campus) and e.start_date>DateTime.now
                       if (web_calendar)
                            if (host.nil?)
                                @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host => host_real.name, :location => e.location, 
                                :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                            elsif(host.id == e.host_id)
                                @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host => host_real.name, :location => e.location, 
                                :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                            end
                             
                        else
                            @json.push({ :id => e.id, :start_date => e.start_date, :end_date => e.end_date,:host => host_real.name, :location => e.location, 
                             :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :event_type => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                         end
                    end
                end
                return @json
            else
                #query with event type restrictions

                id_event_type = id_event_type.to_i
                @event_dates = EventDate.all
                @json = Array.new
                @event_dates.each do |e|
                    event = Event.where(:id => e.event_id).take
                    event_type = EventType.where(:id => event.event_type_id).take
                    faculty = Faculty.where(:id => event.faculty_id).take
                    host_real = User.where(:id => e.host_id).take
                    check_user_booked = BookedHour.check_user_booked(e, user)

                    if(!(user.academic_type.eql? 'Funcionario') and event_type.name.eql? "Taller de Yoga")
                        next
                    end
                    if(user.academic_type.eql? 'Funcionario' and !(event_type.name.eql? "Taller de Yoga"))
                        next
                    end
                    if (e.remaining_capacity>0 or check_user_booked) and (event_type.id == id_event_type) and e.start_date>DateTime.now
                        if (web_calendar)
                            if (host.nil?)
                                @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host => host_real.name, :location => e.location, 
                                :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                            elsif(host.id == e.host_id)
                                @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host => host_real.name, :location => e.location, 
                                :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                            end
                             
                        else
                            @json.push({ :id => e.id, :start_date => e.start_date, :end_date => e.end_date,:host => host_real.name, :location => e.location, 
                             :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :event_type => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                         end
                    end
                end
                return @json
            end
        else
            if !(id_campus.nil?)
                id_campus = id_campus.to_i
                #query with campus restrictions
                @event_dates = EventDate.all
                @json = Array.new
                @event_dates.each do |e|
                    event = Event.where(:id => e.event_id).take
                    event_type = EventType.where(:id => event.event_type_id).take
                    faculty = Faculty.where(:id => event.faculty_id).take
                    host_real = User.where(:id => e.host_id).take
                    check_user_booked = BookedHour.check_user_booked(e, user)

                    if(!(user.academic_type.eql? 'Funcionario') and event_type.name.eql? "Taller de Yoga")
                        next
                    end
                    if(user.academic_type.eql? 'Funcionario' and !(event_type.name.eql? "Taller de Yoga"))
                        next
                    end
                    if (e.remaining_capacity>0 or check_user_booked) and (faculty.id == id_campus) and e.start_date>DateTime.now
                       if (web_calendar)
                            if (host.nil?)
                                @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host => host_real.name, :location => e.location, 
                                :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                            elsif(host.id == e.host_id)
                                @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host => host_real.name, :location => e.location, 
                                :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                            end
                             
                        else
                            @json.push({ :id => e.id, :start_date => e.start_date, :end_date => e.end_date,:host => host_real.name, :location => e.location, 
                             :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :event_type => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                         end
                    end
                end
                return @json
            else
                #query without restrictions
                @event_dates = EventDate.all
                @json = Array.new
                @event_dates.each do |e|
                    event = Event.where(:id => e.event_id).take
                    event_type = EventType.where(:id => event.event_type_id).take
                    faculty = Faculty.where(:id => event.faculty_id).take
                    host_real = User.where(:id => e.host_id).take
                    check_user_booked = BookedHour.check_user_booked(e, user)

                    if(!(user.academic_type.eql? 'Funcionario') and event_type.name.eql? "Taller de Yoga")
                        next
                    end
                    if(user.academic_type.eql? 'Funcionario' and !(event_type.name.eql? "Taller de Yoga"))
                        next
                    end
                    if (e.remaining_capacity>0 or check_user_booked) and e.start_date>DateTime.now
                        if (web_calendar)
                            if (host.nil?)
                                @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host => host_real.name, :location => e.location, 
                                :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                            elsif(host.id == e.host_id)
                                @json.push({ :id => e.id, :start => e.start_date, :end => e.end_date,:host => host_real.name, :location => e.location, 
                                :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :title => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                            end
                             
                        else
                            @json.push({ :id => e.id, :start_date => e.start_date, :end_date => e.end_date,:host => host_real.name, :location => e.location, 
                             :capacity => e.capacity, :remaining_capacity => e.remaining_capacity, :event_type => event_type.name, :faculty => faculty.name, :user_booked => check_user_booked})
                         end
                    end
                end
                return @json
            end
        end

    end
    def self.create_event_dates(initial_date, final_date, start_time, end_time, day, event_id, host_id, location, capacity)
        start_time = Chronic.parse(start_time)
        end_time = Chronic.parse(end_time)
        initial_date = Chronic.parse(initial_date, :endian_precedence => :little)
        final_date = Chronic.parse(final_date, :endian_precedence => :little)

        start_hour = start_time.strftime("%H")
        start_minute = start_time.strftime("%M")
        end_hour = end_time.strftime("%H")
        end_minute = end_time.strftime("%M")
     
        #start_hour = start_time[0..1]
        #start_minute = start_time[3..4]
        #end_hour = end_time[0..1]
        #end_minute = end_time[3..4]
        current_date = initial_date.change(hour: start_hour, min: start_minute)
        final_date= final_date.change(hour: end_hour, min: end_minute)
        current_date = Chronic.parse(current_date.to_s)
        
        id_test = 0
        puts final_date.strftime("%D").inspect
        puts current_date.strftime("%D").inspect
        puts (final_date.strftime("%F")>=current_date.strftime("%F")).inspect

        if initial_date.strftime("%A").eql? day.day # initial_date has the same day as the activity
            while final_date.strftime("%F")>=current_date.strftime("%F") do

                start_time_aux = Chronic.parse((current_date.change(hour: start_hour, min: start_minute)).to_s)
                end_time_aux = Chronic.parse((current_date.change(hour: end_hour, min: end_minute)).to_s)
                event_date = EventDate.create(event_id: event_id, start_date: start_time_aux, end_date: end_time_aux, host_id: host_id, location: location, capacity: capacity, remaining_capacity: capacity)

                event_date.save!

                current_date = Chronic.parse('next ' +day.day, :now => current_date)
                current_date = Chronic.parse((current_date.change(hour: start_hour, min: start_minute)).to_s)
                id_test = event_date.id
            end
        else
            current_date = Chronic.parse('next ' + day.day, :now => current_date)

            while final_date.strftime("%F")>=current_date.strftime("%F") do

                start_time_aux = Chronic.parse((current_date.change(hour: start_hour, min: start_minute)).to_s)
                end_time_aux = Chronic.parse((current_date.change(hour: end_hour, min: end_minute)).to_s)
                event_date = EventDate.create(event_id: event_id, start_date: start_time_aux, end_date: end_time_aux, host_id: host_id, location: location, capacity: capacity, remaining_capacity: capacity)

                event_date.save!

                current_date = Chronic.parse('next ' +day.day, :now => current_date)
                current_date = Chronic.parse((current_date.change(hour: start_hour, min: start_minute)).to_s)
                id_test = event_date.id
                
            end
        end

    end
    
end