module Authorize
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def super_admin
    if !(current_user.super_admin)
      respond_to do |format|
        format.html { redirect_to root_path} #, notice: 'You need to be Admin to access this page' }
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  def admin
    if !(current_user.admin)
      respond_to do |format|
        format.html { redirect_to root_path} #, notice: 'You need to be Admin to access this page' }
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  def logged
    if !(user_signed_in?)
      respond_to do |format|
        format.html { redirect_to root_path}#, notice: 'You need to be Admin to access this page' }
        format.json { render status: :unprocessable_entity }
      end
    end
  end

end