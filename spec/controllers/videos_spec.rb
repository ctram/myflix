require_relative '../spec_helper'

# TODO: code tests for videos#show and videos#search

describe VideosController do
  before :each do
    session[:user_id] = 1 # In order for the GET to videos#index to complete, a user must be logged in, so you must simulate that by setting session[:user_id] to non-nil
    Fabricate(:video)  # Video variable needs to be a instance variable for it to show up in the describe blocks below.
    Fabricate(:video)
  end

  describe "#index" do
    it 'assigns @videos' do
      get :index
      expect(assigns(:videos)).to eq(Video.all)
      expect(assigns(:videos).count).to be 2
    end
  end

  describe "#show" do
    it 'assigns @video' do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
  end

  describe "#search" do

    it 'return an array' do
      get :search
      expect(assigns(:search_results).class).to be(Array)
    end

    it 'matches no videos and assigns @search_results' do
      get :search, search_term:'cheese'
      expect(assigns(:search_results)).to eq([])
    end

    it 'matches all videos if search_term is an empty string and assigns search_results' do
      get :search, search_term:''
      expect(assigns(:search_results)).to eq(Video.all)
    end

    it 'matches one video and assigns @search_results' do
      video = Fabricate(:video) do
        name 'Dances with Wolves'
        description 'A guy dances with wolves.'
      end
      get :search, search_term:'wolves'
      expect(assigns(:search_results)).to eq([video])
    end

    it 'matches two videos and assigns @search_results' do
      video1 = Fabricate(:video) do
        name 'Dances with Wolves'
        description 'A guy dances with wolves.'
      end
      video2 = Fabricate(:video) do
        name 'Three Wolves'
        description 'Three wolves power.'
      end
      get :search, search_term:'wolves'
      expect(assigns(:search_results)).to eq([video1, video2])
    end

  end

end
