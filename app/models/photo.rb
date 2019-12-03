class Photo < ApplicationRecord
  belongs_to :camera

  has_one :notification, as: :notifiable, dependent: :destroy
  mount_base64_uploader :image, ImageUploader

  scope :latest, ->{ order created_at: :desc }

  delegate :title, :info, :user, to: :camera, prefix: true, allow_nil: true

  after_save -> {CreateNotificationJob.perform_later(self)}

end
