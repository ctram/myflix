class Rating < ActiveRecord::Base
  belongs_to :video

  validates_presence_of :score, :review_id

end
