class Camera < ApplicationRecord
  has_secure_token

  validates :title, length: {maximum: 255}
  validates :info, length: {maximum: 255}

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :videos, dependent: :destroy

  scope :latest ,->{ order created_at: :DESC }
end
