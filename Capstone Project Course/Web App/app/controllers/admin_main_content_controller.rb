class AdminMainContentController < ApplicationController
  include Authorize
  before_action :logged
  before_action :admin

  def display
  end

end
