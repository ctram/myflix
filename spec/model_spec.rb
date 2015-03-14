require 'spec_helper'

describe Video do
    it 'saves itself' do
      video = Video.new(name:'x')
      video.save
      video.name.should == 'x'
    end
end
