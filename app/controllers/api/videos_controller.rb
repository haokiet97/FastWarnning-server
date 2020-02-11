class Api::VideosController < ActionController::API
  before_action :get_camera, only: %i(create)
  # before_action :attach_data, only: %i(create)

  # protect_from_forgery except: %i(create)


  def create
    @video = @camera.videos.build video_params
    @video.data.attach data: params[:video][:data]
    if @video.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private
  def video_params
    params.require(:video).permit :title, :description
  end

  def get_camera
    @camera = Camera.find_by(id: params[:camera_id]) || Camera.find_by(token: params[:camera_id])
    return if @camera
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render status: :unprocessable_entity }
    end
  end

  def attach_data
    @video.data.attach data: params[:video][:data]
  end
end
