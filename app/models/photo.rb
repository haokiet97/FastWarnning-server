class Photo < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64

  has_one_base64_attached :image
  belongs_to :camera
  has_one :notification, as: :notifiable, dependent: :destroy

  scope :latest, ->{ order created_at: :desc }

  delegate :title, :info, :user, to: :camera, prefix: true, allow_nil: true

  after_save -> {CreateNotificationJob.perform_later(self)}

end
