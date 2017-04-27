class Media:: SoundsController < ApplicationController
  respond_to :html, :js, :json
  include Authorize

  before_action :logged
  before_action :admin, except: [:show]
  before_action :set_sound, only: [:show, :edit, :update, :destroy]

  # GET /sounds
  # GET /sounds.json
  def index
    @sounds = Sound.all
  end

  # GET /sounds/1
  # GET /sounds/1.json
  def show
    @sound
  end

  # GET /sounds/new
  def new
    @sound = Sound.new
  end

  # GET /sounds/1/edit
  def edit
  end

  #check if still used, pretty sure not
  def program_sound
    @sound = Sound.new(sound_params)
    @sound.added_by=current_user.id
    @sound.program=true
    if @sound.save
      respond_to do |format|
        format.html
        format.json { render :json => @sound }
        format.js{}
      end
    else
      respond_to do |format|
        format.html
        format.json { render status: 400}
      end
    end
  end

  # POST /sounds
  # POST /sounds.json
  def create
    @sound = Sound.new(sound_params)
    @sound.added_by=current_user.id
    @sound.program=false
    respond_to do |format|
      if @sound.save
        @sound.add_labels(params[:Label])
        format.html { redirect_to media_sounds_path}
        format.json { render :show, status: :created, location: [:media, @sound] }
      else
        format.html { render :new }
        format.json { render json: [:media, @sound], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sounds/1
  # PATCH/PUT /sounds/1.json
  def update
    respond_to do |format|
      if @sound.update(sound_params)
        @sound.program=false
        @sound.add_labels(params[:Label])
        format.html { redirect_to [:media, @sound] }
        format.json { render :show, status: :ok, location: [:media, @sound] }
      else
        format.html { render :edit }
        format.json { render json: [:media, @sound], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sounds/1
  # DELETE /sounds/1.json
  def destroy
    @sound.destroy
    respond_to do |format|
      format.html { redirect_to media_sounds_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sound
      @sound = Sound.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sound_params
      params.require(:sound).permit(:name, :description, :added_by, :duration, :sound_file, :program)
    end
end
