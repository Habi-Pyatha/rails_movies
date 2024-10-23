module Api
  module V1
    class MoviesController < ApplicationController
      def index
        @movie=Movie.all
        # puts("type", @movie.class)
        # render json: @movie
        render json: @movie, each_serializer: MovieSerializer
      end

      def show
        @movie_id=params[:id]
        # @found_movie=Movie.includes(:reviews).find_by(tmdb_id: @movie_id)
        @found_movie=Movie.includes(:reviews).find_by(id: @movie_id)
        render json: @found_movie
        # render json: @found_movie
        # render json: { data: @found_movie.as_json(include: {
        #   # review:
        #   reviews: { only: [ :comment, :rating ] }
        # }) }
      end
    end
  end
end
