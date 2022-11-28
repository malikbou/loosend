class Review < ApplicationRecord
  belongs_to :user
  belongs_to :toilet

  has_many :reviews
  has_many :toilets, dependent: :destroy
end
