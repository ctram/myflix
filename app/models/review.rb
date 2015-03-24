class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  
  has_one :rating
end
