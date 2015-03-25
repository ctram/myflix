require 'spec_helper'

describe SessionsController do

  describe 'GET new' do

    it 'redirects to the home page for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to videos_path
    end
  end


  describe 'POST create' do

    context 'with valid credentials' do
      let(:alice) {Fabricate(:user)}

      before do
        post :create, email: alice.email, password: alice.password
      end

      it 'puts the signed in user in the session' do
        expect(session[:user_id]).to eq(alice.id)
      end

      it 'redirects to the home page' do
        expect(response).to redirect_to videos_path
      end

      it 'sets the notice' do
        expect(flash).not_to be_blank
      end

    end

    context 'with invalid credentials' do

      # TODO: DRY up this test -- probably have to use instance variable.
      it 'does not put the signed in user in the session' do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + 'sd'
        expect(session[:user_id]).to be_nil
      end

      it 'redirects to the sign in page' do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + 'sd'
        expect(response).to render_template :new
      end

      it 'sets the error message' do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + 'sd'
        expect(flash[:error]).to_not be_blank
      end

    end
  end

  describe 'DELETE destroy' do

    it 'clears the session for the user' do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      delete :destroy, id: alice.id
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the root path' do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      delete :destroy, id: alice.id
      expect(response).to redirect_to front_path
    end

    it 'sets the notice' do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      delete :destroy, id: alice.id
      expect(flash[:notice]).not_to be_blank
    end

  end
end
