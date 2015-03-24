require_relative '../spec_helper'

describe Rating do
  it {should belong_to :video}
  it {should validate_presence_of :score}
  it {should validate_presence_of :user_id} # XXX: do you need to test for the presence of user_id? This should happen automatically on the UI, right? i.e., since a rating is created by the user, the form will guarantee a user_id? Is this redundant?
  it {should validate_presence_of :video_id}
  it {should validate_presence_of :review_id}
end
