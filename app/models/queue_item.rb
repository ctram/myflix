class QueueItem < ActiveRecord::Base
  belongs_to :my_queue
  belongs_to :video
end
