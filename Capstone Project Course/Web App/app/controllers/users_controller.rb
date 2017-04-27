class UsersController < ApplicationController
	include Authorize

	before_action :logged
	before_action :admin
  before_action :super_admin
  before_action :set_user

  def deauthorize
    unless @user.super_admin
      @user.admin = false
      @user.save
    end
    redirect_to admin_management_index_path
  end

  def authorize
    @user.admin = true
    @user.save
    redirect_to admin_management_index_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end