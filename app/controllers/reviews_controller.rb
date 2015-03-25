class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @review = Review.new(params_review)
    @review.user_id = current_user.id
    @review.video_id = params[:video_id]
    @review.rating = params[:Rating]


    if @review.save
      flash[:notice] = "Your review has been successfully saved."
      redirect_to video_path(params[:video_id])
    else
      @video = Video.find(params[:video_id])
      @reviews = Review.all.select{|review| review.video_id == @video.id}
      render 'videos/show'
    end
  end

  private

  def params_review
    params.require(:review).permit(:title, :rating, :body)
  end
end
