class Toilet < ApplicationRecord
  has_many :reviews, :toilet_features
end
