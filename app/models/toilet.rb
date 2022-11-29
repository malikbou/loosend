class Toilet < ApplicationRecord
  has_many :reviews
  has_many :toilet_features

  validates :name, :address, :opens_at, :closes_at, :fee, :toilet_code, :rating, presence: true

  validates :fee, numericality: true

  include PgSearch::Model
  pg_search_scope :search_by_name_address_description_category,
                  against: %I[name address],
                  using: {
                    tsearch: { prefix: true }
                  }
  # multisearchable against: [:name, :address, :capacity]

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
