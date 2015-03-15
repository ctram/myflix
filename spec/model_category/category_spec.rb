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
end
