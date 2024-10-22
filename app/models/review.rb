class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  validates :movie_id, presence: true
  validates :user_id, presence: true
  validates :comment, presence: true
  validates :rating, presence: true
end
