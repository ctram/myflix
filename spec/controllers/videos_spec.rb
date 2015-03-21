require_relative '../spec_helper'

# TODO: code tests for videos#show and videos#search

describe VideosController do
  before :each do
    # session[:user_id] = 1
    # FIXME: video variable is not carrying down to the describe blocks below.
    # FIXME: Fabricate(:video) seems to be saving to the test database, but then it does not persist in the describe blocks below.
  end

  describe "#index" do
    it 'assigns @videos' do
      session[:user_id] = 1 # In order for the GET to videos#index to complete, a user must be logged in, so you must simulate that by setting session[:user_id] to non-nil
      video = Fabricate(:video)
      
      Video.all << video
      get :index
      expect(assigns(:videos)).to eq([video])
    end
  end
  #
  # describe "#show" do
  #   it 'assigns @video' do
  #   end
  # end


  #
  # describe "search" do
  #
  # end

end
