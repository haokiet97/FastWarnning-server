class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform photo
    Notification.create user_id: photo.camera_user.id, notifiable: photo, notice: "Phát hiện có xâm nhập ở #{photo.camera_title}|#{photo.camera_info}. Kiểm tra ngay!"
  end
end
