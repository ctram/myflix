class VideosController < ApplicationController

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    term = params[:term]
    @matches = Video.search_by_title(term)
  end

  private

  def params_video

  end
end
