class Admin:: ContentController < ApplicationController
	include Authorize

	before_action :logged
	before_action :admin
	
	def display
	end
end