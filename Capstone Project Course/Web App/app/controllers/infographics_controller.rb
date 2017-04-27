#Bad practicies, should DY
class InfographicsController < ApplicationController
  include Authorize

  before_action :set_infographic, only: [:show, :edit, :update, :destroy]
  before_action :logged
  before_action :admin

  def order
    infographic_id=params['ID']
    params.as_json.each do |image_id,data|
      begin
        if Integer(image_id)
          image_sec = ImageSequence.where(image_id:image_id,infographic_id:infographic_id).first
          image_sec.order = data['order']
          image_sec.save
          image = Image.find(image_id)
          image.description = data['description']
          image.save
        end
      rescue
        nil
      end
    end
    head :ok
  end

  # GET /infographics
  # GET /infographics.json
  def index
    @infographics = Infographic.all
  end

  # GET /infographics/1
  # GET /infographics/1.json
  def show
  end

  # GET /infographics/new
  def new
    @infographic = Infographic.new
  end

  # GET /infographics/1/edit
  def edit
  end

  # POST /infographics
  # POST /infographics.json
  def create
    @infographic = Infographic.new(infographic_params)
    @infographic.added_by=current_user.id
    correct_format = true
    if params[:images].present?
      correct_format = @infographic.check_content(params[:images])
    end
    if correct_format === false
      redirect_to new_infographic_path, notice: 'Image content was not correct type'
    else
      respond_to do |format|
        if @infographic.save
          @infographic.add_topics(params[:Label])
          if params[:images]
            @infographic.create_images(params[:images], current_user.id)
          end
          format.html { redirect_to infographics_path}
          format.json { render :show, status: :created, location: @infographic }
          format.js {}
        else
          format.html { render :new }
          format.json { render json: @infographic.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /infographics/1
  # PATCH/PUT /infographics/1.json
  def update
    correct_format = true
    if params[:images].present?
      correct_format = @infographic.check_content(params[:images])
    end
    if correct_format===false
      redirect_to new_infographic_path, notice: 'Image content wasnt correct type'
    else
      respond_to do |format|
        if @infographic.update(infographic_params)
          @infographic.add_topics(params[:Label])
          format.html { redirect_to infographics_path }
          format.json { render :show, status: :ok, location: @infographic }
        else
          format.html { render :edit }
          format.json { render json: @infographic.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /infographics/1
  # DELETE /infographics/1.json
  def destroy
    @infographic.delete_images
    @infographic.destroy
    respond_to do |format|
      format.html { redirect_to infographics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_infographic
      @infographic = Infographic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def infographic_params
      params.require(:infographic).permit(:name, :description, :added_by)
    end
end
