class ProgramsController < ApplicationController
  include Authorize

  before_action :logged
  before_action :admin, except: [:unlock]
  before_action :set_program, only: [:show, :edit, :update, :destroy]

  def order
    program_id=params['ID']
    params.as_json.each do |sound_id,data|
      begin
        if Integer(sound_id)
          sound_sec = SoundSequence.where(sound_id:sound_id,program_id:program_id).first
          sound_sec.order = data['order']
          sound_sec.save
          sound = Sound.find(sound_id)
          sound.name = data['name']
          sound.description = data['description']
          sound.save
        end
      rescue
        nil
      end
    end
    head :ok
  end

  def unlock
    aux = UserProgram.where(user_id:current_user.id, program_id: params['program']).first
    update = false
    if !aux
      aux = UserProgram.create(user_id:current_user.id, program_id: params['program'], current_sound:2)
      update = true
    else
      if params['current_sound'].to_i < aux.program.sounds.count
        if params['current_sound'].to_i == aux.current_sound
          aux.current_sound = params['current_sound'].to_i + 1
          aux.save
          update = true
        end
      else
        aux.current_sound = aux.program.sounds.count
        aux.save
      end
    end
    respond_to do |format|
      format.json { render json:{'program_id': params['program'], 'current_sound': aux.current_sound,
                                 'update': update},  status: :ok }
    end
  end

  def show
    respond_to do |format|
        format.html { redirect_to programs_path}
        format.json { render json:@program.as_json,  status: :ok }
    end
  end

  # GET /programs
  # GET /programs.json
  def index
    @programs = Program.all
  end

  # GET /programs/new
  def new
    @program = Program.new
  end

  # GET /programs/1/edit
  def edit
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.new(program_params)
    @program.added_by=current_user.id
    correct_format = true
    #if params[:sounds].present?
     # correct_format = @program.check_content(params[:sounds])
    #end
    if correct_format === false
     # redirect_to new_program_path, notice: 'Image content was not correct type'
    else
      respond_to do |format|
        if @program.save
          if params[:sounds]
            @program.create_sounds(params[:sounds], current_user.id)
          end
          format.html { redirect_to programs_path}
          format.json { render :show, status: :created, location: @program }
          format.js {}

        else
          format.html { render :new }
          format.json { render json: @program.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # PATCH/PUT /programs/1
  # PATCH/PUT /programs/1.json
  def update
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to programs_path }
        format.json { render :show, status: :ok, location: @program }
      else
        format.html { render :edit }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program.delete_sounds
    @program.destroy
    respond_to do |format|
      format.html { redirect_to programs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.require(:program).permit(:description, :name)
    end
end