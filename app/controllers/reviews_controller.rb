class ReviewsController < ApplicationController
  def create

    review = Review.new(params_review)
    if review.save
      flash[:notice] = "Your review has been successfully saved."
      redirect_to video_path(params[:video_id])
    else
      flash[:error] = 'There was an error in saving your post.'
      @video = Video.new(params[:video_id])
      render 'videos#show'
    end
  end

  private

  def params_review
    params.require(:review).permit(:title, :rating, :body)
  end
end
