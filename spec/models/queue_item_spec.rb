require 'spec_helper'

describe QueueItem do
  it {should belong_to :my_queue}
  it {should belong_to :video}

end
