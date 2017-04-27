class AdminCalendarController < ApplicationController
	include Authorize

	before_action :logged
	before_action :admin

	def display
		@event = Event.new
		@event_types = EventType.all
	    @teachers = User.where(admin:true)
	  	@faculties = Faculty.all
	  	@current_user = current_user
	  	@days = Day.all
	  	
	  	gon.date = Chronic.parse('2/1/2012', :endian_precedence => :little)
  end
end