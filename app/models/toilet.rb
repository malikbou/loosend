class Toilet < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :toilet_features
  has_many :features, through: :toilet_features

  validates :name, :address, :opens_at, :closes_at, :fee, :toilet_code, :rating, presence: true
  validates :fee, numericality: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def self.with_features(features)
    feature_amount = features.count
    toilet_ids = ToiletFeature.where(feature: features).map(&:toilet_id)
    # only select the toilets that have them multiple times
    uniq_toilet_ids = toilet_ids.select { |e| toilet_ids.count(e) == feature_amount }.uniq
    self.where(id: uniq_toilet_ids)
  end

  def distance(latitude, longitude)
    @lewagon_coordinates = [51.532667, -0.076991]
    Geocoder::Calculations.distance_between(@lewagon_coordinates, [latitude, longitude], options = { units: :mi }).round(1)
  end
end
