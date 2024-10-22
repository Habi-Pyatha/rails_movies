class MoviesController < ApplicationController
  def index
    url = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1"
    @img="https://image.tmdb.org/t/p/w200"
    @movies=HTTP.get("#{url}&api_key=#{ENV["API_KEY"]}").body.to_s
    @movies_json=JSON.parse(@movies)
    #  render json: movies_json["results"]
    @movies_results=@movies_json["results"]
    # render json: @movies_results[0]
    # render json: @movies_results
    #  render json: @movies_json
  end
  def show
    @movie_id=params[:id]
    @found_movie=Movie.includes(reviews: :user).find_by(tmdb_id: @movie_id)
    if !@found_movie

      url="https://api.themoviedb.org/3/movie/#{@movie_id}?language=en-US"
      # @movie=HTTP.get("#{url}&api_key=#{ENV["API_KEY"]}").body.to_s
      response=HTTP.get("#{url}&api_key=#{ENV["API_KEY"]}")
      if response.status.success?
        @movie=response.body.to_s
        @movie_json=JSON.parse(@movie)
        # render json: @movie_json

        Movie.create(
          original_title: @movie_json["original_title"],
          overview: @movie_json["overview"],
          poster_path: @movie_json["poster_path"],
          runtime: @movie_json["runtime"],
          status: @movie_json["status"],
          imdb_id: @movie_json["imdb_id"],
          tmdb_id: @movie_json["id"],
          vote_average: @movie_json["vote_average"],
          vote_count: @movie_json["vote_count"],
          backdrop_path: @movie_json["backdrop_path"],
        )
        @found_movie=Movie.includes(reviews: :user).find_by(tmdb_id: @movie_id)

      end
    end
    @review=Review.new
      review_url="https://api.themoviedb.org/3/movie/#{@movie_id}/reviews?language=en-US&page=1"
      review_response=HTTP.get("#{review_url}&api_key=#{ENV["API_KEY"]}")
      if review_response.status.success?
        @reviews=review_response.body.to_s
        @reviews_json=JSON.parse(@reviews)["results"]
        # @reviews_json=@reviews_js["results"]
        # @reviews_json.each do |review|
        #   Review.create(
        #     # movie_id: Movie.find_by(tmdb_id: @movie_json["id"]).id,
        #     movie_id: @movie_json["id"],
        #     # author: review["author"],
        #     user_id: 123,
        #     comment: review["content"],
        #     rating: review.dig("author_details", "rating")

        #     )
        #   end

        # @reviews_saved = Review.where(movie_id: @movie_json["id"])
        # @reviews_saved=Review.all
        # @reviews_saved=Review.where(movie_id: Movie.find_by(tmdb_id: @movie_json["id"]).id)
        @comments=@found_movie.reviews.includes(:user)
        @review=Review.new
        # render json: @revies_json
        # @movie_review=Movie.includes(:reviews).find(params[:id])
        # @reviews=@movie_review.reviews
      else
        logger.error("Failed to fetch reviews:#{review_response.status}-#{review_response.body}")
      end
  end
end
