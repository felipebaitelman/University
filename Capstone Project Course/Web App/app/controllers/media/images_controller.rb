class Media:: ImagesController < ApplicationController
  include Authorize

  before_action :logged
  before_action :admin, except: [:show]
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.added_by=current_user.id
    respond_to do |format|
      if @image.save
        @image.add_labels(params[:Label])
        format.html { redirect_to [:media, @image] }
        format.json { render :show, status: :created, location: [:media, @image] }
      else
        format.html { render :new }
        format.json { render json: [:media, @image.errors], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        #@image.added_by=current_user.id
        @image.add_labels(params[:Label])
        format.html { redirect_to [:media, @image] }
        format.json { render :show, status: :ok, location: [:media, @image] }
      else
        format.html { render :edit }
        format.html { redirect_to media_images_url }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to media_images_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:name, :description, :added_by, :image_file)
    end
end
