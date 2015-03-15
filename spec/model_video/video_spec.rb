require 'spec_helper'

describe Video do

  it {should belong_to :category}
  it {should validate_presence_of :name}
  it {should validate_presence_of :description}

  describe '::search_by_title' do
    it 'should return an empty array or a filled array if no matching video is found.' do
        expect(Video.search_by_title('Healthclif')).to eq []
    end
  end
end
