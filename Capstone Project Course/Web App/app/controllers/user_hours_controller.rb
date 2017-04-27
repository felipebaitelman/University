class UserHoursController < ApplicationController
	include Authorize
	before_action :logged

	def display
		gon.current_user = current_user.email
		gon.event_type = nil
 
		@event_types = EventType.all
	    @teachers = User.where(admin:true)
	  	@faculties = Faculty.all
  	end
end