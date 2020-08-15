class Video < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64

  has_one_base64_attached :data
  # has_one_attached :data
  VIOLENT_STATUS = {violent: "violent", nonviolent: "nonviolent"}.freeze
  enum action_type: VIOLENT_STATUS

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, length: { maximum: 500 }

  belongs_to :camera

  before_destroy :destroy_data
  # after_save ->{ ConvertVideoJob.perform_now self }

  scope :latest, -> { order created_at: :desc }

  def data_path
    ActiveStorage::Blob.service.path_for(data.key)
  end

  private
  def destroy_data
    data.purge
  end
end
