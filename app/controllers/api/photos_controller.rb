class Api::PhotosController < ActionController::API
  before_action :get_camera, only: %i(new create)

  # protect_from_forgery except: %i(create)

  def create
    @photo = @camera.photos.build photo_params
    @photo.image = { data: params[:photo][:image] }
    if @photo.save
      render status: :accepted
    else
      render json: @photo.errors, status: :unprocessable_entity
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

  def photo_params
    params.require(:photo).permit :title
  end

  def image_params
    params.require(:photo).permit :image
  end
end
