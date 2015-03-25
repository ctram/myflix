class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @review = Review.new(review_params)

    @review.user_id = current_user.id
    @review.video_id = params[:video_id]
    @video = Video.find(params[:video_id])

    if @review.save
      flash[:notice] = "Your review has been successfully saved."
      redirect_to @video 
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating, :user_id, :video_id)
  end
end
