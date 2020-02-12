class CamerasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_camera, :valid_camera, except: %i(index new create)
  before_action :get_photos, :get_videos, only: %i(show)

  # GET /cameras
  # GET /cameras.json
  def index
    @cameras = current_user.cameras.latest.page(params[:page]).per 6
  end

  # GET /cameras/1
  # GET /cameras/1.json
  def show
  end

  # GET /cameras/new
  def new
    @camera = Camera.new
  end

  # GET /cameras/1/edit
  def edit
  end

  # POST /cameras
  # POST /cameras.json
  def create
    @camera = current_user.cameras.build camera_params

    respond_to do |format|
      if @camera.save
        format.html { redirect_to @camera, notice: 'Camera was successfully created.' }
        format.json { render :show, status: :created, location: @camera }
      else
        format.html { render :new }
        format.json { render json: @camera.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cameras/1
  # PATCH/PUT /cameras/1.json
  def update
    respond_to do |format|
      if @camera.update(camera_params)
        format.html { redirect_to @camera, notice: 'Camera was successfully updated.' }
        format.json { render :show, status: :ok, location: @camera }
      else
        format.html { render :edit }
        format.json { render json: @camera.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cameras/1
  # DELETE /cameras/1.json
  def destroy
    @camera.destroy
    respond_to do |format|
      format.html { redirect_to cameras_url, notice: 'Camera was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_camera
    @camera = Camera.find_by(id: params[:id]) || Camera.find_by(token: params[:id])
  end

  def camera_params
    params.require(:camera).permit :title, :info
  end

  def valid_camera
    return if @camera.user == current_user
    flash[:danger] = "You don't have permission!"
    redirect_to videos_path
  end

  def get_photos
    @photos = @camera.photos.latest.page(params[:page]).per 6 if @camera
  end

  def get_videos
    @videos = @camera.videos.latest.page(params[:page]).per 6 if @camera
  end
end
