class ReviewsController < ApplicationController
  def create
    
    redirect_to video_path(params[:video_id])
  end
end
