require 'spec_helper'

describe VideosController do

  context 'with authenticated user' do

    before :each do
      user = Fabricate(:user,
                                name_first: Faker::Name.name,
                                name_last: Faker::Name.name,
                                email: Faker::Internet.email,
                                password: Faker::Internet.password
                              )
      session[:user_id] = user.id # In order for the GET to videos#index to complete, a user must be logged in, so you must simulate that by setting session[:user_id] to non-nil

      Fabricate(:video)  # Video variable needs to be a instance variable for it to show up in the describe blocks below.
      Fabricate(:video)
    end

    describe " GET index" do
      # Going to leave this test here, but NOTE: per Kevin, we should NOT test whether call to a controller's action will render the default template. Why? Because that would be testing something we expect Rails to do by default, instead of testing our CODE. "Test what you own".
      it 'renders the index view template' do
        get :index
        expect(response).to render_template :index # this should obviously work because this is the default nature of Rails.
      end

      it 'assigns @videos' do
        get :index
        expect(assigns(:videos)).to eq(Video.all)
      end
    end

    describe "GET show" do

      before do
        @video = Fabricate(:video)
      end

      it 'assigns @video' do
        get :show, id: @video.id
        expect(assigns(:video)).to eq(@video)
      end

      it 'assigns @review' do
        get :show, id: @video.id
        expect(assigns(:review)).to be_an_instance_of(Review)
      end

      it 'assigns @rating' do
        get :show, id: @video.id
      end
    end

    describe "GET search" do

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
        expect(assigns(:search_results)).to eq(Video.all.sort_by{|video| video.name})
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

  context 'with UNauthenticated user' do

    describe 'GET index' do

      it 'redirects to front_path' do
        get :index
        expect(response).to redirect_to front_path
      end

    end

    describe 'GET show' do

      it 'redirects to front_path' do
        get :show, id:1 # Assume user tries to submit params in address bar.
        expect(response).to redirect_to front_path
      end

    end

    describe 'GET search' do

      it 'redirects to front_path' do
        get :search
        expect(response).to redirect_to front_path
      end

    end

  end
end
