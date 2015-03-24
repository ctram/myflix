require_relative '../spec_helper'

describe ReviewsController do
  describe 'POST create;' do
    it 'saves a review' do
      initial_reviews_count = Review.all.count
      Fabricate(:review)
      expect(Review.all.count).to be > initial_reviews_count

    end
  end
end
