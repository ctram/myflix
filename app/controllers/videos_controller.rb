class VideosController < ApplicationController
  before_action :require_user

  def index
    @videos = Video.all

    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @review = Review.new
    @reviews = @video.reviews
  end

  def search
    search_term = params['search_term']
    @search_results = Video.search_by_title(search_term)

  end

end
