class Media:: VideosController < ApplicationController
  include Authorize

  before_action :logged
  before_action :admin, except: [:show]
  before_action :set_video, only: [:show, :edit, :update, :destroy]


  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    #@video.create_log_entry('Video', current_user.id, DateTime.now)
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.added_by=current_user.id
    respond_to do |format|
      if @video.save
        @video.add_labels(params[:Label])
        format.html { redirect_to media_videos_path}
        format.json { render :show, status: :created, location: [:media, @video] }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: [:media, @video.errors], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        #@video.added_by=current_user.id
        @video.add_labels(params[:Label])
        format.html { redirect_to [:media, @video] }
        format.json { render :show, status: :ok, location: [:media, @video] }
      else
        format.html { render :edit }
        format.json { render json: [:media, @video.errors], status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to media_videos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:name, :description, :added_by, :duration, :video_file, :audio_file, :image_file)
    end
end
