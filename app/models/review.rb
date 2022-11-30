class Review < ApplicationRecord
  belongs_to :user
  belongs_to :toilet
  has_many :toilets, dependent: :destroy

  validates :toilet_rating, presence: true
end
