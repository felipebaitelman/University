class RelaxucMailer < ApplicationMailer
  default from: 'no-reply@relaxuc.cl'

  def greeter(contact)
    mail to: contact.email, subject: "invitation to participate"
  end

  def poll(contact, product)
    @contact = contact
    @product = product
    @token   = UXJWT.encode({ contact_id: contact.id, product_id: product.id })
    @url     = "http://uxagencia.ing.puc.cl/polls/1/answer?token=#{@token}"

    mail to: contact.email, subject: "Cinco preguntas para construir calidad"
  end
  
   def agenda_dating(start_time, end_time, initial_date, final_date, event, day)
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
  def booking_confirmation(user, event_date, campus, event_type, host)
      @user = user
      @event_date = event_date
      @campus = campus
      @name = host.name
      @event_type = event_type
      @classroom = event_date.location
      @start = event_date.start_date.strftime("%R")
      @end = event_date.end_date.strftime("%R")
      @date = event_date.start_date.strftime("%d").to_s + '/' + event_date.start_date.strftime("%m").to_s + '/' + event_date.start_date.strftime("%y").to_s
      mail to: user.email, subject: "Confirmación de reserva de hora"
      
  end
  
  def booking_cancel(user, event_date, campus, event_type, host)
      @user = user
      @event_date = event_date
      @campus = campus
      @name = host.name #user.name
      @event_type = event_type
      @classroom = event_date.location
      @start = event_date.start_date.strftime("%R")
      @end = event_date.end_date.strftime("%R")
      @date = event_date.start_date.strftime("%d").to_s + '/' + event_date.start_date.strftime("%m").to_s + '/' + event_date.start_date.strftime("%y").to_s
      mail to: user.email, subject: "Confirmación de cancelación de hora"
      
  end
  
  def booking_cancel_admin(user, event_date, campus, event_type, host)
      @user = user
      @event_date = event_date
      @campus = campus
      @name = host.name #user.name
      @event_type = event_type
      @classroom = event_date.location
      @start = event_date.start_date.strftime("%R")
      @end = event_date.end_date.strftime("%R")
      @date = event_date.start_date.strftime("%d").to_s + '/' + event_date.start_date.strftime("%m").to_s + '/' + event_date.start_date.strftime("%y").to_s
      @current_capacity = event_date.remaining_capacity.to_s
      @capacity = event_date.capacity.to_s
      mail to: host.email, subject: "Un alumno ha cancelado una hora"

      
  end
  
  def booking_cancel_system(user, event_date, campus, event_type, host)
      @user = user
      @event_date = event_date
      @campus = campus
      @name = host.name #user.name
      @event_type = event_type
      @classroom = event_date.location
      @start = event_date.start_date.strftime("%R")
      @end = event_date.end_date.strftime("%R")
      @date = event_date.start_date.strftime("%d").to_s + '/' + event_date.start_date.strftime("%m").to_s + '/' + event_date.start_date.strftime("%y").to_s
      @current_capacity = event_date.remaining_capacity.to_s
      @capacity = event_date.capacity.to_s
      mail to: 'ansiedad@uc.cl', subject: "Un alumno ha cancelado una hora"
      
  end
  
  def admin_cancel(user, campus, event_type, start_date, end_date, location, date, host)
      @user = user

      @campus = campus
      @name = host.name #user.name
      @event_type = event_type
      @classroom = location
      @start = start_date
      @end = end_date
      @date = date
      

      mail to: user.email, subject: "Tu hora ha sido cancelada"
      
  end
  
  def admin_cancel_to_admin(user, campus, event_type, start_date, end_date, location, date, host, array, email)
      @user = user

      @campus = campus
      @name = host.name #user.name
      @event_type = event_type
      @classroom = location
      @start = start_date
      @end = end_date
      @date = date
      @students = array
      

      mail to: email, subject: "La hora ha sido cancelada"
      
  end
  
  def admin_edit(user, campus, event_type, start_date, end_date, location, date, host)
      @user = user

      @campus = campus
      @name = host.name #user.name
      @event_type = event_type
      @classroom = location
      @start = start_date
      @end = end_date
      @date = date
      

      mail to: user.email, subject: "Tu hora ha sido modificada"
      
  end
  
  def admin_edit_to_admin(user, campus, event_type, start_date, end_date, location, date, host, array, email)
      @user = user

      @campus = campus
      @name = host.name #user.name
      @event_type = event_type
      @classroom = location
      @start = start_date
      @end = end_date
      @date = date
      @students = array
      

      mail to: email, subject: "La hora ha sido modificada"
      
  end
  
  def admin_cancel_to_system(user, campus, event_type, start_date, end_date, location, date, host, array)
      @user = user

      @campus = campus
      @name = host.name #user.name
      @event_type = event_type
      @classroom = location
      @start = start_date
      @end = end_date
      @date = date
      @students = array.to_s
      

      mail to: 'ansiedad@uc.cl', subject: "La hora ha sido cancelada"
      
  end
  
  def survey_results(type, content, user)
    @type = type
    @content = content
    
    mail to: user.email, subject: "Resultados evaluacion Relax UC"
      
  end
  
    
end
