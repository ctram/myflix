 require_relative '../spec_helper'

describe UsersController do
  context 'with authenticated user logged in' do

    describe 'GET new' do
      it 'assigns @user' do
        get :new
        expect(assigns(:user)).to be_an_instance_of(User)
      end
    end

    describe 'POST create' do
      context 'with valid input' do
        it 'creates the user' do
          password = Faker::Internet.password(20)
          post :create, user: {
                                name_first:'John',
                                name_last: 'Smith',
                                email: 'js@example.com',
                                password: password,
                                password_confirmation: password
                              }
          expect(User.count).to eq(1)
        end
        it 'redirects to the sign in page' do
          password = Faker::Internet.password(20)
          post :create, user: {
                                name_first:'John',
                                name_last: 'Smith',
                                email: 'js@example.com',
                                password: password,
                                password_confirmation: password
                              }
          expect(response).to redirect_to home_path
        end

      end

      context 'with invalid input' do
        it 'does not create the user' do
          password = Faker::Internet.password(20)
          post :create, user: {
            name_last: 'Smith',
            email: 'js@example.com',
            password: password,
            password_confirmation: password
          }
          expect(User.count).to eq(0)
        end
        it 'renders the :new template' do
          password = Faker::Internet.password(20)
          post :create, user: {
            name_last: 'Smith',
            email: 'js@example.com',
            password: password,
            password_confirmation: password
          }
          expect(response).to render_template :new
        end
        it 'sets @user'
      end
    end
  end

  context 'with Unauthenticated user' do
    describe 'GET new' do

    end

    describe 'GET create' do
    end
  end

end
