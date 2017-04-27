class GamesController < ApplicationController
  include Authorize

  before_action :logged

  def resp_cuadrada
  end

  def resp_guiada
  end
  
  def resp_alternada
  end

end
