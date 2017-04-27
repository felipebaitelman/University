class Api::ProgramsController < Api::ApiController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def current
    current = UserProgram.where(user_id:current_user.id, program_id: params['id']).first
    if !current
      if Program.exists?( params['id'])
        current = UserProgram.create(user_id:current_user.id, program_id: params['id'], current_sound:1)
      end
    end
    if current
      render json: {
          current: current.current_sound,
          "success": true
      }
    else
      render json: {
          "success": false
      }
    end
  end

  def update
    current = UserProgram.where(user_id:current_user.id, program_id: params['id']).first
    if !current
      if Program.exists?( params['id'])
        current = UserProgram.create(user_id:current_user.id, program_id: params['id'], current_sound:1)
      end
    end
    #check request / program is correct
    if current
      #check if its not the last sound of de program
      if params['current'].to_i < current.program.sounds.count
        if params['current'].to_i >= current.current_sound
          current.current_sound = params['current'].to_i + 1
        end
      else
        current.current_sound = current.program.sounds.count
      end
      if current.save
        render json: {
            'new_current': current.current_sound,
            "success": true
        }
      else
        render json: {
            "success": false
        }
      end
    else
      render json: {
          "success": false
      }
    end
  end

end
