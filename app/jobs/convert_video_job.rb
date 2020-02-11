class ConvertVideoJob < ApplicationJob
  include VideosHelper
  queue_as :default

  def perform video
    cvt_video = convert_to_h264 video.data_path
    video.attach cvt_video
  end
end
