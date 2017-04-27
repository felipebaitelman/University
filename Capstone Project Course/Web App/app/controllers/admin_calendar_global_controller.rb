class AdminCalendarGlobalController < ApplicationController
	include Authorize
	before_action :logged
	before_action :admin

	def display
		@event = Event.new
		@event_types = EventType.all
		@teachers = Array.new
    	@users = User.where(admin:true).each do |user|
      		@teachers << user.email
    	end
    	@faculties = Faculty.all
    	@current_user = current_user
    	@days = Array.new
    	@daysaux = Day.all.each do |day|
      		@days << day.spanish_day
    	end
  	end
end