class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :get_camera, only: %i(new)
  before_action :set_video, :valid_user, only: %i(show edit edit update destroy)

  # after_action :attach_data, only: %i(create)

  # GET /videos
  # GET /videos.json
  def index
    @camera = Camera.find_by(id: params[:camera_id])
    unless @camera
      @q = current_user.videos.ransack params[:q]
      @videos = @q.result.latest.page(params[:page]).per 6
    else
      unless @camera.user == current_user
        flash[:danger] = "You don't have permissions!"
        redirect_to videos_path
      else
        @q = @camera.videos.ransack params[:q]
        @videos = @q.result.latest.page(params[:page]).per 6
      end
    end


  end

  # GET /videos/1
  # GET /videos/1.json
  def show
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
    Video.transaction do
      @video = Video.new video_params
      # @video.data = { data: params[:video][:data] }
      respond_to do |format|
        if @video.save
          format.html { redirect_to @video, notice: 'Video was successfully created.' }
          format.json { render :show, status: :created, location: @video }
        else
          format.html { render :new }
          format.json { render json: @video.errors, status: :unprocessable_entity }
        end
      end
    end
    # byebug

  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_video
    @video = Video.find_by id: params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def video_params
    params.require(:video).permit :title, :description, :camera_id, :data
  end

  def data_params
    params.require(:video).permit :data
  end

  def get_camera
    @camera = Camera.find_by(id: params[:camera_id]) || Camera.find_by(token: params[:camera_id])
    return if @camera
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render status: :unprocessable_entity }
    end
  end

  def valid_user
    return if current_user.videos.include? @video
    flash[:danger] = "You don't have permissions!"
    redirect_to root_path
  end

  def attach_data
    @video.data.attach data: params[:video][:data]
  end
end
