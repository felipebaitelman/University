class Admin:: StatisticsController < ApplicationController
	include Authorize

	before_action :logged
	before_action :admin

  def display
		@logs = Log.all
		@users = User.all
	end

	def graphs
		@logs = Log.all
		@users = User.all
		@type = params[:type]
	end

end
