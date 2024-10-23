class MovieSerializerSerializer < ActiveModel::Serializer
  attributes :id, :original_title, :overview, :poster_path, :runtime, :status, :imdb_id, :tmdb_id, :vote_average, :vote_count

  has_many :reviews
end
