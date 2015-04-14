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

      context 'from invitation' do

        it 'makes the user follow the inviter' do
          session[:user_id] = nil
          alice = Fabricate(:user)
          invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
          post :create, user: {email: 'joe@example.com', password: 'password', name_first: 'Joe', name_last: 'Smith'}, invitation_token: invitation.token
          joe = User.where(email: 'joe@example.com').first
          expect(joe.follows?(alice)).to be_true
        end

        it 'makes the inviter follow the user' do
          session[:user_id] = nil
          alice = Fabricate(:user)
          invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
          post :create, user: {email: 'joe@example.com', password: 'password', name_first: 'Joe', name_last: 'Smith'}, invitation_token: invitation.token
          joe = User.where(email: 'joe@example.com').first
          expect(alice.follows?(joe)).to be_true
        end

        it 'expires the invitation upon acceptance' do
          session[:user_id] = nil
          alice = Fabricate(:user)
          invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
          post :create, user: {email: 'joe@example.com', password: 'password', name_first: 'Joe', name_last: 'Smith'}, invitation_token: invitation.token
          expect(Invitation.first.token).to be_nil
        end

      end

    end

  end

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

      context 'when sending emails' do
        after {ActionMailer::Base.deliveries.clear}

        it 'sends out email to the user with valid inputs' do
          post :create, user: {email: 'joe@example.com', password: 'password', name_first: 'Joe', name_last: 'Smith'}
          expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
        end

        it "sends out email containing the user's name with valid inputs" do
          post :create, user: {email: 'joe@example.com', password: 'password', name_first: 'Joe', name_last: 'Smith'}
          expect(ActionMailer::Base.deliveries.last.body).to include('Joe Smith')
        end

        it 'does not send out email with invalid inputs' do
          post :create, user: {email: 'joe@example.com'}
          expect(ActionMailer::Base.deliveries).to eq([])
        end

      end

    end

    describe "GET show" do
      it_behaves_like 'requires sign in' do
        let(:action) {get :show, id: 3}
      end

      it 'sets @user' do
        set_current_user
        alice = Fabricate(:user)
        get :show, id: alice.id
        expect(assigns(:user)).to eq(alice)
      end

    end

    describe 'GET new_with_invitation_token' do
      it 'renders the :new view template' do
        invitation = Fabricate(:invitation)
        get :new_with_invitation_token, token: invitation.token
        expect(response).to render_template :new
      end

      it "sets @user with recipient's email" do
        invitation = Fabricate(:invitation)
        get :new_with_invitation_token, token: invitation.token
        expect(assigns(:user).email).to eq(invitation.recipient_email)
      end

      it 'sets @invitation_token' do
        invitation = Fabricate(:invitation)
        get :new_with_invitation_token, token: invitation.token
        expect(assigns(:invitation_token)).to eq(invitation.token)
      end

      it 'redirects to expired token page for invalid tokens' do
        get :new_with_invitation_token, token: 'asdasd'
        expect(response).to redirect_to expired_token_path
      end

    end


  end
end
