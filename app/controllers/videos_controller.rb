class VideosController < ApplicationController
  before_action :require_user

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def show
    @review = Review.new
    @reviews = Review.all
    @video = Video.find(params[:id])
  end

  def search
    search_term = params[:search_term]
    @search_results = Video.search_by_title(search_term)
  end



  private

  def params_video

  end
end
