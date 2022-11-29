class Toilet < ApplicationRecord
  has_many :reviews
  has_many :toilet_features
end
