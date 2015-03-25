class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_presence_of :body, :user_id, :video_id, :title, :rating

end
