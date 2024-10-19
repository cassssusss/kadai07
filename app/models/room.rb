class Room < ApplicationRecord
  has_many :reservations
  has_one_attached :image
  belongs_to :user

  validates :name, :description, :price, :address, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
end
