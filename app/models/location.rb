class Location < ApplicationRecord
  validates :locate, presence: true
  validates :description, length: {maximum: 500}
  has_many :cameras
end
