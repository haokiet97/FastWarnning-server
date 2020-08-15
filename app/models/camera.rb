class Camera < ApplicationRecord
  has_secure_token

  validates :title, presence: true, length: {maximum: 255}
  validates :info, length: {maximum: 255}

  belongs_to :user
  belongs_to :location
  has_many :photos, dependent: :destroy
  has_many :videos, dependent: :destroy

  scope :latest ,->{ order created_at: :DESC }
  scope :latest_with_location ,->{ order location_id: :asc,created_at: :desc }
end
