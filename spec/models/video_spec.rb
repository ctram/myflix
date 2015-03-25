require 'spec_helper'

describe Video do

  it {should belong_to :category}

  it {should have_many :reviews}

  it {should validate_presence_of :name}
  it {should validate_presence_of :description}

  describe '::search_by_title' do

    it 'should return an empty array if no match is found' do
      expect(Video.search_by_title('heathclif')).to eq []
    end

    it 'should return an array of one video if a match is found' do
      Video.all << Video.create(name:'heathclif', description:'A video about a funny cat.')
      expect(Video.search_by_title('heathclif').count).to be > 0
    end

    it 'should match with a partial search term' do
      Video.all << Video.create(name:'heathclif', description:'A video about a funny cat.')
      Video.all << Video.create(name:'heathbar', description:'About a candy bar.')
      expect(Video.search_by_title('heath').count).to be 2
    end

    it 'should be case insensitive when searching' do
      Video.all << Video.create(name:'heathbar', description:'About a candy bar.')
      expect(Video.search_by_title('HEATH').count).to be 1
    end

    it 'should return matches ordered by title' do
      Video.all << Video.create(name:'heathclif', description:'A video about a funny cat.')
      Video.all << Video.create(name:'heathbar', description:'About a candy bar.')
      matches = Video.search_by_title('heath')
      expect(matches.sort_by{|video|video.name}).to eq matches
    end

  end

  describe '#average_rating' do
    let(:video) {Fabricate(:video)}
    let(:user) {Fabricate(:user)}

    it 'returns nil if there are no reviews yet' do
      expect(video.average_rating).to be_nil
    end

    it 'returns a score if there is one review' do
      review = Fabricate(
                          :review,
                          user_id: user.id,
                          video_id: video.id,
                          title: Faker::Lorem.sentence,
                          rating: (Random::rand * 5).ceil,
                          body: Faker::Lorem.paragraph
                        )

      review.user_id = user.id
      review.video_id = video.id
      video.reviews << review
      expect(video.average_rating).not_to be_nil
    end

    it 'returns a score if there are two reviews' do
      user1 = Fabricate(:user)
      review1 = Fabricate(
                            :review,
                            user_id: user1.id,
                            video_id: video.id,
                            title: Faker::Lorem.sentence,
                            rating: (Random::rand * 5).ceil,
                            body: Faker::Lorem.paragraph
                          )

      user2 = Fabricate(:user)
      review2 = Fabricate(
                            :review,
                            user_id: user2.id,
                            video_id: video.id,
                            title: Faker::Lorem.sentence,
                            rating: (Random::rand * 5).ceil,
                            body: Faker::Lorem.paragraph
                          )

      video.reviews << review1
      video.reviews << review2
      expect(video.average_rating).not_to be_nil
    end
  end
end
