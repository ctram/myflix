class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.video_id = params[:video_id]
    @review.rating = params[:Rating]
    @video = Video.find(params[:video_id])


    if @review.save
      flash[:notice] = "Your review has been successfully saved."
      redirect_to @video #video_path(params[:video_id])
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :body)
  end
end
