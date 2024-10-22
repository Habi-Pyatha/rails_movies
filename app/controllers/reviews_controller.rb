class ReviewsController < ApplicationController
  def new
    @review=Review.new
  end
  def create
    @review=Review.new(review_params)
    puts "testing......."
     puts @review.movie_id
     puts @review.user_id
     puts @review.comment
     puts @review.rating
     # run= JSON.parse(@review)
     # puts run
     if @review.save
      redirect_to movie_path(@review.movie.tmdb_id)
     else
      puts @review.errors.full_messages
    flash[:error] = @review.errors.full_messages.to_sentence
        redirect_to movies_path
     end

    # if @user.save
    #   # render json: @user_review, status: :created
    # else
    #   render json: { error: "Missing Parameters" }, status: :bad_request
    # end
  end

  private

  def review_params
    params.require(:review).permit(:movie_id, :user_id, :comment, :rating)
  end
end
