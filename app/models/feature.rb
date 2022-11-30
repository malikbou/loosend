class Feature < ApplicationRecord
  has_many :toilet_features
  has_many :toilets, through: :toilet_features, :source => "toilet"
end
