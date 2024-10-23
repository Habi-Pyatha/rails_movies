class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :comment, :user_id

  # belongs_to :movie
end
