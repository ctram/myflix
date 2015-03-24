require_relative '../spec_helper'

describe ReviewsController do
  describe 'POST create;' do
    it 'saves a review' do
      initial_reviews_count = Review.all.count
      video = Fabricate(:video)
      review = Fabricate(:review)
      post :create, {
                      video_id: video.id,
                      review: {
                                body:review.body,
                                title: review.title,
                                rating: review.rating
                              }
                    }
      expect(Review.all.count).to be > initial_reviews_count
    end
  end
end
