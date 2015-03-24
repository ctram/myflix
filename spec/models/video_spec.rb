require_relative '../spec_helper'

describe Video do

  it {should belong_to :category}

  it {should have_many :ratings}
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
end
