module VideosHelper
  require "streamio-ffmpeg"

  def convert_to_h264 file_path
    cvt_video = Tempfile.new([file_path, '.mp4'])
    video = FFMPEG::Movie.new(file_path)
    video.transcode cvt_video, video_encoding_settings
    cvt_video
  end

  def video_encoding_settings
    %w(-c:v libx264 -preset slow -profile:v baseline -crf 26 -movflags faststart -c:a aac -b:a 320k -f mp4 -strict -2)
  end
end
