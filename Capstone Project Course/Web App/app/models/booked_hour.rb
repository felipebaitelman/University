class BookedHour < ApplicationRecord
    has_many :users
    has_one :event_date
    
    def count_users
        BookedHour.where(:id_event_date => self.id_event_date).count
    end
    
    
    def self.check_user_booked(event_date, user)
       checking = BookedHour.where(:id_event_date => event_date.id, :id_user => user.id)
       !(checking.empty?)
    end
    
    def self.admin_cancel(id_event_date, event_date)
        
        @books = BookedHour.where(:id_event_date => id_event_date)
        @event_date = EventDate.where(:id => id_event_date).take
        @host = User.where(:id => @event_date.host_id).take
        event = Event.where(:id => event_date.event_id).take
        faculty = Faculty.where(:id => event.faculty_id).take
        event_type = EventType.where(:id => event.event_type_id).take
        start = (event_date.start_date.strftime("%R")).to_s
        _end = (event_date.end_date.strftime("%R")).to_s
        date = (event_date.start_date.strftime("%x")).to_s
        @array = Array.new
        @books.each do |b|
            @user = User.where(:id => b.id_user).take
            @event_date = EventDate.where(:id => b.id_event_date).take
            @host = User.where(:id => @event_date.host_id).take
            @array.push('   Mail: ' + @user.email + ' RUT: ' + (@user.rut).to_s )
            event = Event.where(:id => event_date.event_id).take
            faculty = Faculty.where(:id => event.faculty_id).take
            event_type = EventType.where(:id => event.event_type_id).take
            start = (event_date.start_date.strftime("%R")).to_s
            _end = (event_date.end_date.strftime("%R")).to_s
            date = event_date.start_date.strftime("%d").to_s + '/' + event_date.start_date.strftime("%m").to_s + '/' + event_date.start_date.strftime("%y").to_s
            
            RelaxucMailer.admin_cancel(@user, faculty.name, event_type.name, start, _end, event_date.location, date, @host).deliver_later
            b.destroy
            #SEND MAIL TO USERS
        end
        
        RelaxucMailer.admin_cancel_to_admin(@user, faculty.name, event_type.name, start, _end, event_date.location, date, @host, @array, 'ansiedad@uc.cl').deliver_later
        RelaxucMailer.admin_cancel_to_admin(@user, faculty.name, event_type.name, start, _end, event_date.location, date, @host, @array, @host.email).deliver_later
        
    end
    
    
    
    def self.admin_edit(id_event_date, event_date)
        
        @books = BookedHour.where(:id_event_date => id_event_date)
        @event_date = EventDate.where(:id => id_event_date).take
        @host = User.where(:id => @event_date.host_id).take
        event = Event.where(:id => event_date.event_id).take
        faculty = Faculty.where(:id => event.faculty_id).take
        event_type = EventType.where(:id => event.event_type_id).take
        start = (event_date.start_date.strftime("%R")).to_s
        _end = (event_date.end_date.strftime("%R")).to_s
        date = (event_date.start_date.strftime("%x")).to_s
        @array = Array.new
        @books.each do |b|
            @user = User.where(:id => b.id_user).take
            @event_date = EventDate.where(:id => b.id_event_date).take
            @host = User.where(:id => @event_date.host_id).take
            @array.push('   Mail: ' + @user.email + ' RUT: ' + (@user.rut).to_s )
            event = Event.where(:id => event_date.event_id).take
            faculty = Faculty.where(:id => event.faculty_id).take
            event_type = EventType.where(:id => event.event_type_id).take
            start = (event_date.start_date.strftime("%R")).to_s
            _end = (event_date.end_date.strftime("%R")).to_s
            date = event_date.start_date.strftime("%d").to_s + '/' + event_date.start_date.strftime("%m").to_s + '/' + event_date.start_date.strftime("%y").to_s
            
            RelaxucMailer.admin_edit(@user, faculty.name, event_type.name, start, _end, event_date.location, date, @host).deliver_later
            
            
            #SEND MAIL TO USERS
        end
        RelaxucMailer.admin_edit_to_admin(@user, faculty.name, event_type.name, start, _end, event_date.location, date, @host, @array, 'ansiedad@uc.cl').deliver_later
        RelaxucMailer.admin_edit_to_admin(@user, faculty.name, event_type.name, start, _end, event_date.location, date, @host, @array, @host.email).deliver_later
        
        
    end
    
    def get_capacity
        EventDate.where(:id => self.id_event_date).take.capacity
    end
    
    def self.cancel_book(id_event_date, email_user)
        @user = User.where(:email => email_user).take
        @booked_hour = BookedHour.where("id_event_date = ? AND id_user = ?" , id_event_date, @user.id).take
        @event_date = EventDate.where(:id => id_event_date).take
        @host = User.where(:id => @event_date.host_id).take
        unless @booked_hour.nil?
            @booked_hour.destroy
            remaining_capacity = @event_date.remaining_capacity + 1
            @event_date.update(remaining_capacity: remaining_capacity)
            event = Event.where(:id => @event_date.event_id).take
            faculty = Faculty.where(:id => event.faculty_id).take
            event_type = EventType.where(:id => event.event_type_id).take
            
            RelaxucMailer.booking_cancel(@user, @event_date, faculty.name, event_type.name, @host).deliver_later
            RelaxucMailer.booking_cancel_admin(@user, @event_date, faculty.name, event_type.name, @host).deliver_later
            RelaxucMailer.booking_cancel_system(@user, @event_date, faculty.name, event_type.name, @host).deliver_later
            return true
        else
            return false
        end
    end
        
    
    def self.book(event_date, id_user)
        @event_date = event_date
        @user = User.where(:id => id_user).take
        @host = User.where(:id => @event_date.host_id).take
        
        id_event_date = event_date.id
        booked_hour = BookedHour.create(id_event_date: id_event_date, id_user: id_user)
        booked_hour.save
        remaining_capacity = event_date.remaining_capacity - 1
        @event_date.update(remaining_capacity: remaining_capacity)
        event = Event.where(:id => @event_date.event_id).take
        faculty = Faculty.where(:id => event.faculty_id).take
        event_type = EventType.where(:id => event.event_type_id).take
        
        
        RelaxucMailer.booking_confirmation(@user, @event_date, faculty.name, event_type.name, @host).deliver_later

    end
    
end
