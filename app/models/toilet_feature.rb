class ToiletFeature < ApplicationRecord
  belongs_to :toilet
  belongs_to :feature

  has_many :features
  has_many :toilets, dependent: :destroy

  validates :toilet_id, uniqueness: { scope: :feature_id }
end
