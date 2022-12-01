class Review < ApplicationRecord
  belongs_to :user
  belongs_to :toilet
  has_many :toilets

  validates :toilet_rating, presence: true
end
