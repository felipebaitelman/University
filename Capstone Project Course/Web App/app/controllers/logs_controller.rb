class LogsController < ApplicationController
  include Authorize

  before_action :logged
  before_action :admin, only: [:index, :destroy]
  before_action :set_log, only: [:show, :destroy]


  def create_conc
    @log = Log.new(media_id:1, media_type:'Infographic', user_id: current_user.id, date: DateTime.now)
    @log.save
    head :ok
  end

  def create_des
    @log = Log.new(media_id:2, media_type:'Infographic', user_id: current_user.id, date: DateTime.now)
    @log.save
    head :ok
  end

  def create_emp
    @log = Log.new(media_id:3, media_type:'Infographic', user_id: current_user.id, date: DateTime.now)
    @log.save
    head :ok
  end

  def create_audio
    @log = Log.new(log_params)
    @log.date = DateTime.now
    @log.user_id = current_user.id
    @log.save
    head :ok
  end

  def create_program
    @log = Log.new(log_params)
    @log.date = DateTime.now
    @log.user_id = current_user.id
    @log.save
    head :ok
  end

  # GET /logs
  # GET /logs.json
  def index
    @logs = Log.all
  end

  # GET /logs/1
  # GET /logs/1.json
  def show
  end

  # DELETE /logs/1
  # DELETE /logs/1.json
  def destroy
    @log.destroy
    respond_to do |format|
      format.html { redirect_to logs_url }
      format.json { head :no_content }
    end
  end

  private

  def find_media
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.require(:log).permit(:date, :media_id, :media_type, :user_id)
    end
end
