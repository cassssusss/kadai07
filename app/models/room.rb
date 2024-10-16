class Room < ApplicationRecord
  has_many :reservations
  has_one_attached :image
  belongs_to :user
  validates :name, :description, :price, :address, presence: true
end
