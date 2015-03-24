class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  has_one :rating

  validates_presence_of :user_id, :rating, :video_id
end
