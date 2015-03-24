class Rating < ActiveRecord::Base
  belongs_to :video

  validates_presence_of :score, :user_id, :review_id, :video_id

end
