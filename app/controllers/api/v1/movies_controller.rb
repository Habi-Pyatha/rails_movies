module Api
  module V1
    class MoviesController < ApplicationController
      def index
        url = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1"
        @img="https://image.tmdb.org/t/p/w200"
        @movies=HTTP.get("#{url}&api_key=#{ENV["API_KEY"]}").body.to_s
        @movies_json=JSON.parse(@movies)
        #  render json: movies_json["results"]
        @movies_results=@movies_json["results"]
        # render json: @movies_results[0]
        render json: @movies_results
        #  render json: @movies_json
      end

      def show
        @movie_id=params[:id]
        @found_movie=Movie.includes(:reviews).find_by(tmdb_id: @movie_id)
        # render json: @found_movie
        render json: { data: @found_movie.as_json(include: {
          reviews: { only: [ :comment, :rating ] }
        }) }
      end
    end
  end
end
