class Admin::ManagementController < ApplicationController
	include Authorize

	before_action :logged
	before_action :admin
  before_action :super_admin


  def index
		@users = User.where(admin:true)
	end

	def index_all
    @users, @alphaParams = User.all.alpha_paginate(params[:letter],
                                                   {bootsrap3: true, paginate_all: true}) {|user| user.email}
  end

end
