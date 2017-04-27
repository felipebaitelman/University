class UserCalendarController < ApplicationController
	include Authorize
	before_action :logged

	def display
    gon.current_user = current_user.email
		gon.event_type = nil
		gon.campus = nil
		gon.host = nil
		if current_user.academic_type.eql? 'Funcionario'
			gon.user_student = false
			@event_types = EventType.where(name: "Taller de Yoga")
			
		else
			gon.user_student = true
			@event_types = EventType.where.not(name: "Taller de Yoga")
		end
 
		#@event_types = EventType.all
    @teachers = User.where(admin:true).where.not(email: 'dsinay@uc.cl')
    @faculties = Faculty.all
  end
end