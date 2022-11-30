class Toilet < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :toilet_features
  has_many :features, through: :toilet_features, :source=>"feature"

  validates :name, :address, :opens_at, :closes_at, :fee, :toilet_code, :rating, presence: true
  validates :fee, numericality: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
