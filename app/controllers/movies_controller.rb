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
    @movie=HTTP.get("#{url}&api_key=#{ENV["API_KEY"]}").body.to_s
    @movie_json=JSON.parse(@movie)
    # render json: @movie_json
  end
end
