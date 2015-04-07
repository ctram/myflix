 require 'spec_helper'

describe UsersController do

  context 'with authenticated user logged in' do

    before do
      session[:user_id] = 1
    end

    describe 'GET new' do

      it 'redirects to videos_path' do
        get :new
        expect(response).to redirect_to(videos_path)
      end

    end

    describe 'POST create' do

      it 'redirect_to videos_path' do
        post :create
        expect(response).to redirect_to(videos_path)
      end

    end

  end

  # TODO: fill out the rest of these tests.
  context 'with Unauthenticated user' do

    describe 'GET new' do

      it 'assigns @user' do
        get :new
        expect(assigns(:user)).to be_an_instance_of(User)
      end

    end

    describe 'POST create' do

      context 'with valid data' do

        it 'assigns @user' do
          get :new
          expect(assigns(:user)).to be_an_instance_of(User)
        end

        it 'saves a User object' do
          initial_num_users = User.all.count
          post :create, user: Fabricate.attributes_for(:user)
          expect(User.all.count).to be > initial_num_users
        end

        it 'logs the new user in' do
          post :create, user: Fabricate.attributes_for(:user)
          expect(session[:user_id]).not_to be(nil)
        end

      end

      context 'with invalid data' do

        it 'renders :new' do
          post :create, user: {name_first: 'Smith'}
          expect(response).to render_template(:new)
        end

      end

    end
  end
end
