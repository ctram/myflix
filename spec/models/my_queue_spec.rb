require 'spec_helper'

describe MyQueue do
  it {should belong_to :user}
  it {should have_many :queue_items}
end
