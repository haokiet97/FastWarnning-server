class Location < ApplicationRecord
  validates :locate, presence: true
  validates :description, length: {maximum: 500}

  belongs_to :user
  has_many :cameras, dependent: :destroy

  scope :latest, -> { order created_at: :desc }

end
