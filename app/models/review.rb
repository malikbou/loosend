class Review < ApplicationRecord
  belongs_to :user
  belongs_to :toilet

  has_many :toilets, dependent: :destroy

  validates :rating, presence: true
end
