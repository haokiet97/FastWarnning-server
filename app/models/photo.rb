class Photo < ApplicationRecord
  belongs_to :camera

  mount_uploader :image, ImageUploader
end
