require 'spec_helper'

describe MyQueuesController do

  context 'with authenticated user' do
    let(:user) {Fabricate(:user)}

    before do
      session[:user_id] = user.id
    end

    context 'without an existing my_queue' do

      describe 'GET show' do

        it 'creates a my_queue for user' do
          user.my_queue = nil
          get :show
          expect(user.my_queue).not_to eq(nil)
        end

      end

    end

    context 'with an existing my_queue' do

      before do
        MyQueue.create(user_id: user.id)
      end

      describe 'GET show' do
        it 'assigns @my_queue' do
          get :show
          expect(assigns(:my_queue)).to be_an_instance_of(MyQueue)
        end

        it '@my_queue is associated with the user' do
          get :show
          expect(assigns(:my_queue).user).to eq(user)
        end
      end
    end
  end

  context 'with unauthenticated user' do

    describe 'GET show' do

      it 'redirects to front_path' do
        get :show
        expect(response).to redirect_to front_path
      end
    end
  end
end
