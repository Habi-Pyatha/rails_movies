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
    url="https://api.themoviedb.org/3/movie/#{@movie_id}?language=en-US"
    # @movie=HTTP.get("#{url}&api_key=#{ENV["API_KEY"]}").body.to_s
    response=HTTP.get("#{url}&api_key=#{ENV["API_KEY"]}")
    if response.status.success?
    @movie=response.body.to_s
    @movie_json=JSON.parse(@movie)
    # render json: @movie_json
    unless Movie.exists?(tmdb_id: @movie_json["tmdb_id"])
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
      )
    end
    else
      logger.error("Failed to fetch movie:#{response.status}-#{response.body}")
    end
  end

  def create
  end
end
