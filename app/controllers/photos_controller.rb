class PhotosController < ApplicationController
  before_action :authenticate_user!, except: %i(create)
  before_action :get_camera, only: %i(new create)
  before_action :set_photo, :valid_user, only: %i(show edit update destroy)

  protect_from_forgery except: %i(create)

  # GET /photos
  # GET /photos.json
  def index
    @camera = Camera.find_by(id: params[:camera_id])
    unless @camera
      @photos = current_user.photos.latest.page(params[:page]).per 6
    else
      unless current_user.cameras.include? @camera
        flash[:danger] = "You don't have permissions!"
        redirect_to cameras_path
      else
        @photos = @camera.photos.latest.page(params[:page]).per 6
      end
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = @camera.photos.build photo_params
    @photo.image = {data: params[:photo][:image]}
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render status: :accepted }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_camera
    @camera = Camera.find_by(id: params[:camera_id]) || Camera.find_by(token: params[:camera_id])
    return if @camera
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render status: :unprocessable_entity }
    end
  end

  def set_photo
    @photo = Photo.find_by id: params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
    params.require(:photo).permit :title
  end

  def image_params
    params.require(:photo).permit :image
  end

  def valid_user
    return if current_user.photos.include? @photo
    flash[:danger] = "You don't have permissions!"
    redirect_to root_path
  end
end
