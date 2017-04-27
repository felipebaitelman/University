class SessionsController < Devise::SessionsController

	def new
		redirect_to login_pages_path
	end

end