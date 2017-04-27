class Api::LogsController < Api::ApiController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def long_audio
    log = Log.new(media_id:params[:id], media_type:'Sound', user_id: current_user.id, date: DateTime.now)
    if log.save
      render json: {
          "success": true
      }
    else
      render json: {
          "success": false
      }
    end
  end

  def nature
    log = Log.new(media_id:params[:id], media_type:'Video', user_id: current_user.id, date: DateTime.now)
    if log.save
      render json: {
          "success": true
      }
    else
      render json: {
          "success": false
      }
    end  end

  def infographics
    log = Log.new(media_id:params[:id], media_type:'Infographic', user_id: current_user.id, date: DateTime.now)
    if log.save
      render json: {
          "success": true
      }
    else
      render json: {
          "success": false
      }
    end
  end

end
