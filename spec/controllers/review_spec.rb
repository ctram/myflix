require 'spec_helper'

describe ReviewsController do

  describe 'POST create;' do

    it 'saves a review' do
      initial_reviews_count = Review.all.count
      user = Fabricate(:user)
      video = Fabricate(:video)
      session[:user_id] = user.id
      expect {
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
      }.to change { Review.count }.by 1
    end

  end
end
