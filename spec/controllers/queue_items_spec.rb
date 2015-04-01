require 'spec_helper'

describe QueueItemsController do

  describe 'GET index' do

    it 'sets @queue_items to the queue_items of the logged in user' do
      alice = Fabricate(:user)

      session[:user_id] = alice.id

      queue_item1 = Fabricate(:queue_item, user:alice)
      queue_item2 = Fabricate(:queue_item, user:alice)

      get :index

      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it 'redirects to the sign in page for unauthenticated users' do
      get :index
      expect(response).to redirect_to sign_in_path
    end

  end

  describe 'POST create' do

    it 'redirects to the my queue page' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it 'craetes a queue_item' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it 'creates teh queue_item that is associated with the video' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it 'creates the queue item that is associated with the signed in user' do
      alice = Fabricate(:user)

      session[:user_id] = alice.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(alice)
    end

    it 'puts the video as the last one in the queue' do
      alice =  Fabricate(:user)
      session[:user_id] = alice.id
      video1 = Fabricate(:video)
      Fabricate(:queue_item, video: video1, user: alice)
      video2 = Fabricate(:video)
      post :create, {video_id: video2.id}
      video2_queue_item = QueueItem.where(video_id: video2.id, user_id: alice.id).first
      expect(video2_queue_item.position).to eq(2)
    end

    it 'does not add the video into the queue if the video is already in the queue' do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      video = Fabricate(:video)
      Fabricate(:queue_item, video: video, user: alice)
      post :create, video_id: video.id
      expect(alice.queue_items.count).to eq(1)
    end

    it 'redirects to the sign in page for unauthenticated users' do
      post :create, video_id: 2
      expect(response).to redirect_to sign_in_path
    end

  end

  describe 'DELETE destroy' do

    let(:alice) {Fabricate(:user)}

    before do
      session[:user_id] = alice.id
    end

    it 'redirects to my queue page' do
      queue_item = Fabricate(:queue_item, user: alice)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it 'updates the position of all videos on the queue' do
      queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
      queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
      delete :destroy, id: queue_item1.id
      expect(queue_item2.reload.position).to eq(1)
    end

    it 'deletes the queue item' do
      queue_item = Fabricate(:queue_item, user: alice)
      alice_init_queue_items_count = alice.queue_items.count
      delete :destroy, id: queue_item.id
      expect(alice.queue_items.count).to eq(alice_init_queue_items_count - 1)
    end

    it 'does not delete the queue item if the queue item does not belong to the current user' do
      bob = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: bob)
      bob_init_queue_items_count = bob.queue_items.count
      delete :destroy, id: queue_item.id  # try to destroy bob's queue_item while logged in as alice.
      expect(bob.queue_items.count).to eq(bob_init_queue_items_count)
    end

    it 'redirects to the sign in page for unauthenticated users' do
      session[:user_id] = nil
      delete :destroy, id:1
      expect(response).to redirect_to sign_in_path
    end

  end

  describe 'POST update_index' do

    let(:alice) {Fabricate(:user)}

    # alice has four queue_items with defined positions, 1 - 4.
    before do
      session[:user_id] = alice.id
      alice.queue_items << Fabricate(:queue_item, position: 1)
      alice.queue_items << Fabricate(:queue_item, position: 2)
      alice.queue_items << Fabricate(:queue_item, position: 3)
      alice.queue_items << Fabricate(:queue_item, position: 4)
      @alice_queue_item1 = alice.queue_items[0]
      @alice_queue_item2 = alice.queue_items[1]
      @alice_queue_item3 = alice.queue_items[2]
      @alice_queue_item4 = alice.queue_items[3]
    end

    context 'with valid data' do

      it 'updates queue for one updated position' do
        post(:update_index, queue_items: [{id: @alice_queue_item1.id, position: 4}])
        expect(@alice_queue_item1.reload.position).to eq(4)
      end

      it 'updates queue for two updated positions' do
        post(:update_index, queue_items: [{id: @alice_queue_item1.id, position: 4}, {id: @alice_queue_item2.id, position: 2}])
        expect(@alice_queue_item1.reload.position).to eq(4)
        expect(@alice_queue_item2.reload.position).to eq(1)
      end

      it 'updates queue for four updated positions' do
        post(:update_index, queue_items: [{id: @alice_queue_item1.id, position: 4}, {id: @alice_queue_item2.id, position: 2}, {id: @alice_queue_item3.id, position: 1}, {id: @alice_queue_item4.id, position: 3}])
        expect(@alice_queue_item1.reload.position).to eq(4)
        expect(@alice_queue_item2.reload.position).to eq(2)
        expect(@alice_queue_item3.reload.position).to eq(1)
        expect(@alice_queue_item4.reload.position).to eq(3)
      end

      it 'accepts a position number that is greater than the current length of the queue' do
        post(:update_index, queue_items: [{id: @alice_queue_item1.id, position: 9}])
        expect(@alice_queue_item1.reload.position).to eq(4)
        expect(@alice_queue_item2.reload.position).to eq(1)
        expect(@alice_queue_item3.reload.position).to eq(2)
        expect(@alice_queue_item4.reload.position).to eq(3)
      end

    end

    context 'with invalid data' do
      it 'updates with queue_item that belongs to another user'
      it 'updates with a float instead of a intger'
    end
  end

end


# TODO: test that user can ONLY update queue items that he owns. Why? A malicious user can change the queue_item IDs through the browser inspector and change the queue_item attributes of some other user.
