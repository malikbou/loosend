class Toilet < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :toilet_features
end
