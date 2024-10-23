class ReviewsController < ApplicationController
  def new
    @review=Review.new
  end
  def create
    @review=Review.new(review_params)
     # puts "testing......."
     #  puts @review.movie_id
     #  puts @review.user_id
     #  puts @review.comment
     #  puts @review.rating
     # run= JSON.parse(@review)
     # puts run
     if @review.save
      respond_to do |format|
       format.html { redirect_to movie_path(@review.movie.tmdb_id) }
       format.turbo_stream
      end
     else
      puts @review.errors.full_messages
    flash[:error] = @review.errors.full_messages.to_sentence
        redirect_to movies_path
     end
  end
    def destroy
          # debugger
          # @review = Review.
          @review=Review.find(params[:id])
          @review.destroy
        respond_to do |format|
          format.html { redirect_to movie_path(@review.movie.tmdb_id), notice: "Review was sucessfully destroyed." }
          format.turbo_stream
        end
    end



  private

  def review_params
    params.require(:review).permit(:movie_id, :user_id, :comment, :rating)
  end
end
