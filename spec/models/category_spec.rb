require 'spec_helper'

describe Category do
=begin
  Use shoulda matchers to simplify testing code.
  Test your implementation of models and
  associations instead of testing what Rails does
  by default.

  Alternately you would test the Category model by
  doing something like this:

  before :all do
    @category = Category.create(name:'Animals')
    @category.videos << Video.create(name:'Cats')
    @category.videos << Video.create(name:'Dogs')
  end

  it 'should have many videos' do
    expect(@category.videos.count).to be > 0
  end
=end
  it {should have_many :videos}
  it {should validate_presence_of :name}

  describe '#recent_videos' do
    let(:category) {Category.create(name: 'Dogs')}

    it 'should return an empty array if there are no recent videos' do
      expect(category.recent_videos).to eq []
    end

    it 'should return an array of 2 videos if there are only 2 videos in the Category' do
      category.videos << Video.create(name:'Hot Dogs', description:'About hot dogs')
      category.videos << Video.create(name:'Cold Dogs', description:'About cold dogs')
      expect(category.recent_videos.count).to be 2
    end

    it 'should return at most 6 videos' do
      category.videos << Video.create(name:'Hot Dogs', description:'About hot dogs')
      category.videos << Video.create(name:'Cold Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Medium Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Small Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Warm Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Lukewarm Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Freezing Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Atomic Dogs', description:'About cold dogs')
      expect(category.recent_videos.count).to be 6
    end

    it 'should return array of videos ordered by created_at time. Newest added video first.' do
      category.videos << Video.create(name:'Hot Dogs', description:'About hot dogs')
      category.videos << Video.create(name:'Cold Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Medium Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Small Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Warm Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Lukewarm Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Freezing Dogs', description:'About cold dogs')
      category.videos << Video.create(name:'Atomic Dogs', description:'About cold dogs')

      expect(category.recent_videos).to eq category.videos.sort_by{|video| video.created_at}.reverse.slice(0,6)
    end

  end
end
